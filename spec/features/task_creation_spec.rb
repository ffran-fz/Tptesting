require 'rails_helper'

RSpec.feature "Task creation", type: :feature do
  scenario 'User creates a task successfully' do
    # Visita la página de creación de tarea
    visit new_task_path

    # Rellena el formulario de creación de tarea
    fill_in 'Title', with: 'Test Task'
    fill_in 'Body', with: 'This is the body of the test task.'

    # Haz clic en el botón para crear la tarea
    click_button 'Create Task'

    # Verifica que la tarea fue creada y redirige a la página de la tarea
    expect(page).to have_content('Task was successfully created.')
    expect(page).to have_content('Test Task')
    expect(page).to have_content('This is the body of the test task.')
  end

  scenario 'User fails to create a task with invalid data' do
    # Visita la página de creación de tarea
    visit new_task_path

    # Deja los campos vacíos para simular un error
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''

    # Haz clic en el botón para intentar crear la tarea
    click_button 'Create Task'

    # Verifica que no se haya creado la tarea y que se muestren los errores
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
