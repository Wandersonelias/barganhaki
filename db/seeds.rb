# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

    categorias = Category.create([
        {description: "Hamburgueria",  icon: File.new("#{Rails.root}/app/assets/images/carrinho.png", 'r')},
        {description: "Supermercados", icon: File.new("#{Rails.root}/app/assets/images/carrinho.png", 'r')},
        {description: "Turismo", icon: File.new("#{Rails.root}/app/assets/images/carrinho.png", 'r')},
        {description: "Cafeterias", icon: File.new("#{Rails.root}/app/assets/images/carrinho.png", 'r')},
        {description: "Hotéis", icon: File.new("#{Rails.root}/app/assets/images/carrinho.png", 'r')},
        {description: "Pizzarias", icon: File.new("#{Rails.root}/app/assets/images/carrinho.png", 'r')},
        {description: "Restaurantes", icon: File.new("#{Rails.root}/app/assets/images/carrinho.png", 'r')},
        {description: "Cinemas", icon: File.new("#{Rails.root}/app/assets/images/carrinho.png", 'r')},
        {description: "Saúde", icon: File.new("#{Rails.root}/app/assets/images/carrinho.png", 'r')}
    ])
    ###########################################

    

    User.create(email: "user@oi.com", 
            
            password: "123456", 
            password_confirmation: "123456",
            )
    10.times do
        Product.create(
           title: "Combo Hamburguer Duplo",
           description: "Super combo hamburguer duplo",
           quantity: 10,
           comments: "Lorem ipsum dolor",
           status: true,
           category: Category.all.sample,
           user: User.all.sample,
           image: File.new('/home/wanderson/barganhaki/app/assets/images/burg.png', 'r')
        
            )
    end
                    

    Admin.create(email: "admin@barganhaki.com", 
        name: "Wanderson Elias",
        password: "123456", 
        password_confirmation: "123456",
        role: 0)


    puts "Categorias criadas com sucesso!"
    puts "Administrador criado com sucesso"
    puts "Usuario criado com sucesso!"
    puts "Produtos inseridos com sucesso!"