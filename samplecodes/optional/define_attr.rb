require './optional'

class Module
=begin
  def attr_accessor(*syms)
    syms.each do|sym|
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def #{sym}
          @#{sym}
        end
        def #{sym}=(val)
          @#{sym} = val
        end
      RUBY_EVAL
    end
  end
=end


  def define_attr(*attrs)
    attr_accessor *attrs
    attrs.each{|attr| define_attr_internal attr }
  end

  private
    def define_attr_internal(attr)
      if attr.to_s =~ /^[\w_]+$/
        class_eval do

          define_method "#{attr}=" do |value|
            instance_variable_set("@#{attr}", value)
          end
          
          define_method "#{attr}" do
            instance_variable_get("@#{attr}")
          end

          define_method "#{attr}?" do
            Optional.new(self.send attr.to_sym)
          end

          define_method "#{attr}!" do
            val = self.send attr.to_sym
            if val
              val
            else
              raise Error.new("#{attr} is not found")
            end
          end

        end
      else
        puts "Invalid attr name #{attr}"
      end
    end

end


class Person
  define_attr :contact
end

class Contact
  define_attr :address
end

class Address
  define_attr :province, :city, :street
end

addr = Address.new
addr.province = 'Guangdong'
addr.city = 'Shenzhen'
addr.street = '699'

contact = Contact.new
contact.address = addr

person = Person.new
person.contact = contact

person2 = Person.new

puts person2.contact?.address?.city!
puts person.contact?.address?.city!