require_relative("../db/sql_runner")

class Customer

  attr_accessor( :id, :name, :funds)


  def initialize(options)
    @id = options['id'].to_i
    @name =options.fetch('name')
    @funds =options.fetch('funds').to_i
  end 

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', '#{@funds}') RETURNING *"
    customer =SqlRunner.run( sql ).first
    @id = customer.fetch('id').to_i
  end 

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run( sql )
  end 

  def self.all()
    sql = "SELECT * FROM customers" 
    return Customer.map_items( sql )
  end 

  def self.map_items(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result 
  end 

  def self.map_item(sql) 
    result = Customer.map_items( sql )
    return result.first
  end 

    #this shows all the films being viewed by a particular customer id (its only 1 in this instance)
  def films
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.customer_id = #{@id};"
    return Film.map_items(sql) 
  end 


    # UPDATING SOMETHING
   #i did this command in the psql and it worked, but where do i put it in m ruby files?
  
  #update customers set name = 'TIMAEE' where funds = 300;


 #    DELETE METHOD
 # delete from tickets where customer_id = 67;

end 












