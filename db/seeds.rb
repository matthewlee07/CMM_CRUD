20.times do

    # User     
    user = User.create(
        username: Faker::Name.unique.name,
        password: "password",
        email: Faker::Internet.unique.email
    )

    # Customer
    customer = Customer.create(
        company: Faker::Company.unique.name, 
        address: Faker::Address.street_address, 
        city: Faker::Address.city,
        state: Faker::Address.state, 
        zip: Faker::Address.zip
    )

    # Project
    project = Project.create(
        project_name: Faker::Job.key_skill, 
        customer_id: customer.id
    )

    # Task
    task = Task.create(
        task_name: Faker::Hacker.say_something_smart,
        project_id: project.id,
        user_id: customer.id 
    )

    # Task Entry
    TaskEntry.create(
        note: Faker::Quote.yoda,
        start_time: Faker::Time.backward(30),
        updated_at: Time.now,
        task_id: task.id
    )

end

# User: Admin
admin = User.create(
    username: "SampleAdmin",
    email: "SampleAdmin@email.com",
    password: "password",
    admin: true
)

customer = Customer.create(
    company: "CoverMyMeds",
    address: "2 Miranova Pl",
    city: "Columbus",
    state: "Ohio",
    zip: "43215"
)

# Project
project = Project.create(
    project_name: "Prepare for Interview",
    customer_id: customer.id
)

# Task
task = Task.create(
    task_name: "Learn Rails",
    project_id: project.id,
    user_id: customer.id 
)

# Task Entry
TaskEntry.create(
    note: "Rails and MVC is hard...",
    start_time: Faker::Time.backward(30),
    updated_at: Time.now,
    task_id: task.id
)