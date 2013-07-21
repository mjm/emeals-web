module FoundationHelper
  class SectionBuilder
    attr_reader :slug, :options, :title_block, :content_block
    def initialize(slug, options = {})
      @slug = slug
      @options = options
    end

    def build
      yield self
      self
    end

    def title(options = {}, &block)
      @options[:title_class] = options[:class] if options[:class]
      @title_block = block
    end

    def content(options = {}, &block)
      @options[:content_class] = options[:class] if options[:class]
      @content_block = block
    end
  end

  def section(slug, options = {}, &block)
    builder = SectionBuilder.new(slug, options).build(&block)
    content_tag(:section, class: builder.options[:class]) do
      concat content_tag(:p, content_tag(:a, href: "##{builder.slug}", &builder.title_block),
                         :class => builder.options[:title_class], 'data-section-title' => "")
      concat content_tag(:div, :class => builder.options[:content_class],
                         'data-slug' => builder.slug, 'data-section-content' => '', &builder.content_block)
    end
  end
end
