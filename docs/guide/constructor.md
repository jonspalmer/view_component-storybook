---
layout: default
title: Constructor
parent: Writing ViewComponent Stories
nav_order: 3
---

# Constructor

Sotries configure arguments passed to the component's constructor with `constructor`.

Given a header class that looks like the following:

```ruby
class HeaderComponent < ViewComponent::Base
  def initialize(tag, bold:)
    @tag = tag
    @bold = bold
  end
end
```

To render a HeaderComponent, use the `constructor` method.

```ruby
class HeaderComponentStories < ViewComponent::Storybook::Stories
  story(:h1) do
    constructor("h1", bold: false)
  end
end
```

`constructor` supports positional and keyword arguments as well as optional arguments with default values.

## Controls

`constructor` arguments also support controls making the values dynamicaly configurable in Storybook:

```ruby
class HeaderComponentStories < ViewComponent::Storybook::Stories
  story(:h1) do
    constructor(text("h1"), bold: boolean(false))
  end
end
```

The list of Control options is described in [Controls](/guide/controls.html)

## Validation

ViewComponent Storybook validates that the constructor arguments match allowed arguments of the component constructor  throwing a `ViewComponent::Storybook::StoryConfig::ValidationError` if there is a mismatch.

Each of these examples result in an validation exception:

```ruby
class HeaderComponentStories < ViewComponent::Storybook::Stories
  story(:not_enough_positional_args) do
    constructor(bold: false)
  end

  story(:too_many_positional_args) do
    constructor("h1", "p", bold: false)
  end

  story(:missing_kwargs) do
    constructor("h1")
  end

  story(:extra_kwargs) do
    constructor("h1", bold: false, size: "2em")
  end
end
```

_To view documentation for controls DSL (deprecated) see [legacy_controls_dsl](/guide/legacy_controls_dsl.html)._