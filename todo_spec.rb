require_relative('todo')

describe Task do
  let(:task) { Task.new("Drink whiskey with my BFFs") }

  describe "#initialize" do
    it "creates an object" do
      expect(task).to be_a Object
    end
  end
end

describe List do
  let(:list) { List.new }

  before do
    list.get_list_from_csv('todo.csv')
  end

  describe "#list" do
    it "displays the tasks in the TODO list" do
      expect(list.list.length).to be(13)
    end
  end

  describe "#add" do
    it "adds a task to the TODO list" do
      expect{list.add("Brush my teeth")}.to change{list.list[13]}
    end
  end

  describe "#delete" do
    it "deletes a task from the TODO list" do
      expect{list.delete(2)}.to change{list.list[1].task}
    end
  end

  describe "#completed" do
    it "marks a task as completed on the TODO list" do
      expect{list.completed(4)}.to change{list.list[3].brackets}
    end
  end
end
