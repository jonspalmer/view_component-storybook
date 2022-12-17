# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::StoriesController, type: :request do
  it "returns ok" do
    get "/rails/view_components/content_component/with_string_content"

    expect(response).to have_http_status(:ok)
  end

  it "returns ok for stories with namespaces" do
    get "/rails/view_components/demo/button_component/short_button"

    expect(response).to have_http_status(:ok)
  end

  it "renders the compoent" do
    get "/rails/view_components/demo/button_component/short_button"

    expect(response.body).to have_button(text: "OK")
  end

  it "renders a compoent with positional args" do
    get "/rails/view_components/args_component/default"

    expect(response.body).to have_selector("p", text: "Hello World!")
    expect(response.body).to have_selector("p", text: "How you doing?")
  end

  it "renders a compoent with fixed positional args" do
    get "/rails/view_components/args_component/fixed_args"

    expect(response.body).to have_selector("p", text: "Hello World!")
    expect(response.body).to have_selector("p", text: "How you doing?")
  end

  it "renders a compoent with keyword args" do
    get "/rails/view_components/kwargs_component/default"

    expect(response.body).to have_selector("h1", text: "Hello World!")
  end

  it "renders a compoent with positional and keyword args" do
    get "/rails/view_components/mixed_args_component/default"

    expect(response.body).to have_selector("h1", text: "Hello World!")
    expect(response.body).to have_selector("p", text: "How you doing?")
  end

  it "renders a compoent with fixed positional and keyword args" do
    get "/rails/view_components/mixed_args_component/fixed_args"

    expect(response.body).to have_selector("h1", text: "Hello World!")
    expect(response.body).to have_selector("p", text: "How you doing?")
  end

  it "renders the kitchen sink" do
    get "/rails/view_components/kitchen_sink_component/jane_doe"
    body = Nokogiri::HTML(response.body).css("body div").to_html

    expected_html =
      <<~HTML.strip
        <div>
          <p>My name is Jane Doe</p>
          <p>My Birthday is 1950-03-26</p>
          <p>My favorite color is red</p>
          <p>I like people</p>
          <p>I have 2 pets</p>
          <p>I like to watch football and baseball</p>
          <p>My favorite food is Ice Cream</p>
          <p>I'm feeling happy</p>
          <p>Other things about me {"hair":"Brown","eyes":"Blue"}</p>
        </div>
      HTML

    expect(body).to eq(expected_html)
  end

  it "renders the kitchen sink with params" do
    get "/rails/view_components/kitchen_sink_component/jane_doe", params: {
      name: "John Doe",
      birthday: Date.new(1963, 7, 13).iso8601,
      favorite_color: "green",
      like_people: false,
      number_pets: 0,
      sports: %i[ice_hockey basketball baseball],
      favorite_food: :hot_dog,
      mood: :sad,
      other_things: { hair: "Blonde", eyes: "Green", weight: 175 }
    }
    body_div = Nokogiri::HTML(response.body).css("body div").to_html

    expected_html =
      <<~HTML.strip
        <div>
          <p>My name is John Doe</p>
          <p>My Birthday is 1963-07-13</p>
          <p>My favorite color is green</p>
          <p>I do not like people</p>
          <p>I have no pets</p>
          <p>I like to watch ice_hockey, basketball, and baseball</p>
          <p>My favorite food is hot_dog</p>
          <p>I'm feeling sad</p>
          <p>Other things about me {"hair":"Blonde","eyes":"Green","weight":"175"}</p>
        </div>
      HTML

    expect(body_div).to eq(expected_html)
  end

  it "renders the compoent with supplied parameters" do
    get "/rails/view_components/demo/button_component/short_button", params: { button_text: "My Button" }

    expect(response.body).to have_button(text: "My Button")
  end

  it "renders a compoent with custom controls" do
    get "/rails/view_components/combined_control/combined_text", params: { greeting: "Hello", name: "Nemo" }

    expect(response.body).to have_button(text: "Hello Nemo")
  end

  it "renders a compoent with custom controls for rest args" do
    get "/rails/view_components/combined_control/combined_rest_args",
        params: {
          verb_one: "Heavy",
          noun_one: "Rock",
          verb_two: "Light",
          noun_two: "Feather",
        }

    expect(response.body).to have_selector("p", text: "Heavy Rock")
    expect(response.body).to have_selector("p", text: "Light Feather")
  end

  it "renders a slots component with default values" do
    get "/rails/view_components/slots/default",
        params: {}

    expect(response.body).to have_selector(".card.mt-4")

    expect(response.body).to have_selector(".title", text: "This is my title!")

    expect(response.body).to have_selector(".subtitle", text: "This is my subtitle!")

    expect(response.body).to have_selector(".tab", text: "Tab A")
    expect(response.body).to have_selector(".tab", text: "Tab B")

    expect(response.body).to have_selector(".item", count: 3)
    expect(response.body).to have_selector(".item.highlighted", count: 1)
    expect(response.body).to have_selector(".item.normal", count: 2)

    expect(response.body).to have_selector(".footer.text-blue")
  end

  it "renders a slots component with params values" do
    get "/rails/view_components/slots/default",
        params: {
          classes: "mb-6",
          subtitle: "Subtitle Override!",
          tab2: "Tab 2",
          item2_highlighted: "false",
          footer_classes: "text-green"
        }

    expect(response.body).to have_selector(".card.mb-6")

    expect(response.body).to have_selector(".title", text: "This is my title!")

    expect(response.body).to have_selector(".subtitle", text: "Subtitle Override!")

    expect(response.body).to have_selector(".tab", text: "Tab A")
    expect(response.body).to have_selector(".tab", text: "Tab 2")

    expect(response.body).to have_selector(".item", count: 3)
    expect(response.body).to have_selector(".item.highlighted", count: 0)
    expect(response.body).to have_selector(".item.normal", count: 3)

    expect(response.body).to have_selector(".footer.text-green")
  end

  it "ignores query params that don't match the the compoents args" do
    get "/rails/view_components/demo/button_component/short_button", params: { button_text: "My Button", junk: true }

    expect(response.body).to have_button(text: "My Button")
  end

  it "raises ActionNotFound error for stories that don't exist" do
    expect { get "/rails/view_components/missing_component/short_button" }.to raise_exception(AbstractController::ActionNotFound)
  end

  it "raises ActionNotFound error story that doesn't exist" do
    expect { get "/rails/view_components/demo/button_component/junk" }.to raise_exception(NameError)
  end

  it "returns 200 for a stories index" do
    get "/rails/view_components/demo/button_component"

    expect(response).to have_http_status(:ok)
  end

  describe "component content" do
    it "renders the component string content" do
      get "/rails/view_components/content_component/with_string_content"

      expect(response.body).to have_selector("h1", text: "Hello World!")
    end

    it "renders the component control content" do
      get "/rails/view_components/content_component/with_control_content"

      expect(response.body).to include("<h1>Hello World!</h1>")
    end

    it "renders the component control content overriden by params" do
      get "/rails/view_components/content_component/with_control_content", params: { content: "Hi!" }

      expect(response.body).to include("<h1>Hi!</h1>")
    end

    it "renders the component block content with helper" do
      get "/rails/view_components/content_component/with_helper_content"

      expect(response.body).to have_css("h1 span", text: "Hello World!")
    end
  end

  describe "layout" do
    it "defaults to the application layout" do
      get "/rails/view_components/demo/button_component/short_button"

      expect(response.body).to have_title("Stories Dummy App")
    end

    it "allows stories to set the layout" do
      get "/rails/view_components/layout/default"

      expect(response.body).to have_title( "Stories Dummy App - Admin")
    end

    xit "allows story to override the stories layout" do
      get "/rails/view_components/layout_stories_v2/mobile_layout"

      expect(response.body).to have_title("Stories Dummy App - Mobile")
    end

    xit "allows story to override with no layout" do
      get "/rails/view_components/layout_stories_v2/no_layout"

      expect(response.body).to eq("<button>OK</button>")
    end

    it "allows stories to set no layout" do
      get "/rails/view_components/no_layout/default"

      expect(response.body.strip).to eq("<button>OK</button>")
    end

    xit "allows story to override no layout with a layout" do
      get "/rails/view_components/no_layout_stories_v2/mobile_layout"

      expect(response.body).to have_title("Stories Dummy App - Mobile")
    end
  end
end
