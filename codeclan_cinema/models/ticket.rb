require_relative("../db/sql_runner")
require('pry-byebug')

class Ticket

  attr_accessor( :id, :customer_id, :film_id )

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options.fetch('customer_id').to_i
    @film_id = options.fetch('film_id').to_i
  end 

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ('#{@customer_id}', '#{@film_id}') RETURNING *"
    ticket =SqlRunner.run( sql ).first
    @id = ticket.fetch('id').to_i
  end 

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run( sql )
  end 

  def self.all()
    sql = "SELECT * FROM tickets"
    return Ticket.map_items( sql )
  end 

  def self.map_items(sql)
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new(ticket) }
    return result 
  end 

  def self.map_item(sql) 
    result = Ticket.map_items( sql )
    return result.first
  end 

end 