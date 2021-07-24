# frozen_string_literal: true

RSpec.describe "ViewComponent::Storybook.stories_route", type: :request do
  around(:all) do |example|
    config = Rails.application.config.view_component_storybook

    old_route = config.stories_route
    config.stories_route = "/stories"
    app.reloader.reload!

    example.run

    config.stories_route = old_route
    app.reloader.reload!
  end

  it "returns ok" do
    get "/stories/content_component/with_string_content"

    expect(response).to have_http_status(:ok)
  end
end
