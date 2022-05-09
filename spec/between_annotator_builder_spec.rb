module NumberAnnotator
  RSpec.describe AnnotatorBuider do

    describe "#build_between_annotations" do
      class Student
        attr_reader :marks

        def initialize(marks)
          @marks = marks
        end
      end

      let(:annotable_class) { Student }
      let(:annotable_property) { :marks }
      let(:annotation_name) { "distinction" }
      let(:lower_limit) { 75 }
      let(:upper_limit) { 100 }

      subject { AnnotatorBuider.build_between_annotations(annotable_class, annotable_property, annotation_name, lower_limit, upper_limit) }

      it 'defines a method named <annotation_name>? which returns true if passed number is between the limits' do
        subject
        student_with_80_marks = Student.new(80)
        student_with_75_marks = Student.new(75)
        student_with_100_marks = Student.new(100)
        student_with_74_marks = Student.new(74)
        student_with_101_marks = Student.new(101)

        expect(student_with_80_marks.distinction?).to be_truthy
        expect(student_with_75_marks.distinction?).to be_truthy
        expect(student_with_100_marks.distinction?).to be_truthy
        expect(student_with_74_marks.distinction?).to be_falsey
        expect(student_with_101_marks.distinction?).to be_falsey
      end

      it 'defines a method named <annotable_property>_needed_for_<annotation_name> which returns deficiency' do
        student_with_60_marks = Student.new(60)
        expect(student_with_60_marks.marks_needed_for_distinction).to eq(15) # 75 - 60
      end
    end
  end
end