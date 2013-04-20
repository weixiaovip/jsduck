require 'jsduck/tag/tag'

module JsDuck::Tag
  # Base class for all builtin members.
  class MemberTag < Tag
    # Defines a class member type and specifies a name and several
    # other settings.  For example:
    #
    #     {
    #       :name => :event,
    #       :category => :method_like,
    #       :title => "Events",
    #       :position => MEMBER_POS_EVENT,
    #       # The following are optional
    #       :toolbar_title => "Events",
    #       :subsections => [
    #         {:title => "Static events",
    #          :filter => {:static => false},
    #          :default => true},
    #         {:title => "Instance events",
    #          :filter => {:static => true}},
    #       ]
    #     }
    #
    # The category must be either :property_like or :method_like.
    #
    # Position defines the ordering of member section in final HTML
    # output.
    #
    # Title is shown at the top of each such section and also as a
    # label on Docs app toolbar button unless :toolbar_title is
    # specified.
    #
    # Subsections allows splitting the list of members to several
    # subgroups.  For example methods get split into static and
    # instance methods.
    #
    # - The :filter field defines how to filter out the members for
    #   this subcategory.  :static=>true filters out all members that
    #   have a :static field with a truthy value.  Conversely,
    #   :static=>false filters out members not having a :static field
    #   or having it with a falsy value.
    #
    # - Setting :default=>true will hide the subsection title when all
    #   the members end up in that subsection.  For example when there
    #   are only instance methods, the docs will only contain the
    #   section title "Methods", as by default one should assume all
    #   methods are instance methods if not stated otherwise.
    #
    attr_reader :member_type

    MEMBER_POS_CFG = 1
    MEMBER_POS_PROPERTY = 2
    MEMBER_POS_METHOD = 3
    MEMBER_POS_EVENT = 4
    MEMBER_POS_CSS_VAR = 5
    MEMBER_POS_CSS_MIXIN = 6

    # Called when the member type detected from code doesn't match
    # with the final member type determined from code + doc-comment.
    #
    # The job of this method is then to extract the fields relevant to
    # the member type.
    #
    # The input is a hash of auto-detected data. For example:
    #
    #     {:name => "foo", :type => "String", :default => "hello"}
    #
    # In the context of method :type and :default don't make any
    # sense, so we should return just the name:
    #
    #    {:name => "foo"}
    #
    # Extracting just the :name field is also the default behavior of
    # this method.
    #
    # Note: The special :tagname and :autodetected fields are filtered
    # out automatically, no need to worry about these.
    def process_code(code)
      {:name => code[:name]}
    end

    # This method defines the signature-line of the member.
    # For example it might return something like this:
    #
    #     "apply(source, target) : Object"
    #
    def to_html(context, cls)
    end

  end
end
