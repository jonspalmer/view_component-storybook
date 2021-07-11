# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::StoriesController, type: :request do
  it "returns ok" do
    get "/rails/stories/content_component/default"

    expect(response).to have_http_status(:ok)
  end

  it "returns ok for stories with namespaces" do
    get "/rails/stories/demo/button_component/short_button"

    expect(response).to have_http_status(:ok)
  end

  it "renders the compoent" do
    get "/rails/stories/demo/button_component/short_button"

    expect(response.body).to include("<button>OK</button>")
  end

  it "renders a compoent with positional args" do
    get "/rails/stories/args_component/default"

    expect(response.body).to include("<p>Hello World!</p>")
    expect(response.body).to include("<p>How you doing?</p>")
  end

  it "renders a compoent with keyword args" do
    get "/rails/stories/kwargs_component/default"

    expect(response.body).to include("<h1>Hello World!</h1>")
  end

  it "renders a compoent with positional and keyword args" do
    get "/rails/stories/mixed_args_component/default"

    expect(response.body).to include("<h1>Hello World!</h1>")
    expect(response.body).to include("<p>How you doing?</p>")
  end

  it "renders a compoent with legacy cotrols dsl" do
    get "/rails/stories/legacy_controls_dsl/short_button"

    expect(response.body).to include("<button>OK</button>")
  end

  it "renders the kitchen sink" do
    get "/rails/stories/kitchen_sink_component/jane_doe"
    body = Nokogiri::HTML(response.body).css("body div").to_html

    expected_html = %(<div>
      <p>My name is Jane Doe</p>
      <p>My Birthday is 1950-03-26</p>
      <p>My favorite color is red</p>
      <p>I like people</p>
      <p>I have 2 pets</p>
      <p>I like to watch football and baseball</p>
      <p>My favorite food is Ice Cream</p>
      <p>I'm feeling Happy</p>
      <p>Other things about me {"hair":"Brown","eyes":"Blue"}</p>
    </div>)

    expect(body).to match_html(expected_html)
  end

  it "renders the kitchen sink with params" do
    get "/rails/stories/kitchen_sink_component/jane_doe", params: {
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
    body = Nokogiri::HTML(response.body).css("body div").to_html

    expected_html = %(<div>
      <p>My name is John Doe</p>
      <p>My Birthday is 1963-07-13</p>
      <p>My favorite color is green</p>
      <p>I do not like people</p>
      <p>I have no pets</p>
      <p>I like to watch ice_hockey, basketball, and baseball</p>
      <p>My favorite food is hot_dog</p>
      <p>I'm feeling sad</p>
      <p>Other things about me {"hair":"Blonde","eyes":"Green","weight":"175"}</p>
    </div>)

    expect(body).to match_html(expected_html)
  end

  it "renders the compoent with supplied parameters" do
    get "/rails/stories/demo/button_component/short_button", params: { button_text: "My Button" }

    expect(response.body).to include("<button>My Button</button>")
  end

  it "ignores query params that don't match the the compoents args" do
    get "/rails/stories/demo/button_component/short_button", params: { button_text: "My Button", junk: true }

    expect(response.body).to include("<button>My Button</button>")
  end

  it "returns 404 for a stories that don't exist" do
    get "/rails/stories/missing_component/short_button"

    expect(response).to have_http_status(:not_found)
  end

  it "returns 404 for a story that doesn't exist" do
    get "/rails/stories/demo/button_component/junk"

    expect(response).to have_http_status(:not_found)
  end

  it "returns 404 for a missing story param" do
    get "/rails/stories/demo/button_component"

    expect(response).to have_http_status(:not_found)
  end

  describe "component content" do
    it "renders the component content" do
      get "/rails/stories/content_component/default"

      expect(response.body).to include("<h1>Hello World!</h1>")
    end

    it "renders the component content with helper" do
      get "/rails/stories/content_component/with_helper_content"

      expect(response.body).to include('<h1><a href="#">Hello World!</a></h1>')
    end

    it "renders the component content with constructor" do
      get "/rails/stories/content_component/with_constructor_content"

      expect(response.body).to include('<h1>Hello World!</h1>')
    end
  end

  describe "layout" do
    it "defaults to the application layout" do
      get "/rails/stories/demo/button_component/short_button"

      expect(response.body).to include("<title>Stories Dummy App</title>")
    end

    it "allows stories to set the layout" do
      get "/rails/stories/layout/default"

      expect(response.body).to include("<title>Stories Dummy App - Admin</title>")
    end

    it "allows story to override the stories layout" do
      get "/rails/stories/layout/mobile_layout"

      expect(response.body).to include("<title>Stories Dummy App - Mobile</title>")
    end

    it "allows story to override with no layout" do
      get "/rails/stories/layout/no_layout"

      expect(response.body.strip).to eq("<button>OK</button>")
    end

    it "allows stories to set no layout" do
      get "/rails/stories/no_layout/default"

      expect(response.body.strip).to eq("<button>OK</button>")
    end

    it "allows story to override no layout with a layout" do
      get "/rails/stories/no_layout/mobile_layout"

      expect(response.body).to include("<title>Stories Dummy App - Mobile</title>")
    end
  end
end
