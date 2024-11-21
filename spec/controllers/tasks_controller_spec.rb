require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  # Crear una tarea de prueba para usar en varios tests
  let!(:task) { Task.create!(title: "Test Task", completed: false) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: task.id }
      expect(response).to be_successful
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new task" do
        expect {
          post :create, params: { task: { title: "New Task", completed: false } }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post :create, params: { task: { title: "New Task", completed: false } }
        expect(response).to redirect_to(Task.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new task" do
        expect {
          post :create, params: { task: { title: "", completed: false } }
        }.to_not change(Task, :count)
      end

      it "renders the 'new' template" do
        post :create, params: { task: { title: "", completed: false } }
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: task.id }
      expect(response).to be_successful
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      it "updates the requested task" do
        put :update, params: { id: task.id, task: { title: "Updated Task", completed: true } }
        task.reload
        expect(task.title).to eq("Updated Task")
        expect(task.completed).to be(true)
      end

      it "redirects to the task" do
        put :update, params: { id: task.id, task: { title: "Updated Task", completed: true } }
        expect(response).to redirect_to(task)
      end
    end

    context "with invalid parameters" do
      it "does not update the task" do
        put :update, params: { id: task.id, task: { title: "", completed: false } }
        task.reload
        expect(task.title).not_to eq("")
      end

      it "renders the 'edit' template" do
        put :update, params: { id: task.id, task: { title: "", completed: false } }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to(tasks_path)
    end
  end
end
