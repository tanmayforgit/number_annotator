module NumberAnnotator
  module AnnotatorBuider
    class << self
      def build_between_annotations(annotable_class, annotable_property, annotation_name, lower_limit, upper_limit)
        between_detector = lambda { self.send(annotable_property).between?(lower_limit, upper_limit) }
        deficiency_calculator = lambda { lower_limit -  self.send(annotable_property) }
        annotable_class.send(:define_method, "#{annotation_name}?", &between_detector)
        annotable_class.send(:define_method, "#{annotable_property}_needed_for_#{annotation_name}", &deficiency_calculator)
      end
    end
  end
end