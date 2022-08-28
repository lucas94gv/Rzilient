require 'json'

class Rzilient 

    def welcome
        "
        Welcome to the store
        ------------------------------------------------------------------------------------------
        These are our products:
        (1)  -   AP1   Macbook Pro 13    60€
        (2)  -   LN1   Lenovo Thinkpad   41€
        (3)  -   HP1   HP 850 G5         39€
        ------------------------------------------------------------------------------------------
        Do you want to buy something?
        (1) - Yes
        (2) - No
        "
    end
    
    def checkout 
      option = gets.chomp.to_i
      cart = {}
      offer = false
      
      if buy?(option)
        puts "Press any number that is not assigned to any computer to exit"
        cart.store("ids", [])
        while option < 4
          puts "Add products to the cart, select the number in parentheses to reference it or press any other number to finish the purchase: "
          option = gets.chomp.to_i            
          add_elements_cart(cart, option) if option != 4
        end
    
        # LN1 validation, if there is one we give away others
        # we add only in cart, not in final price
        if cart["ids"].include?("LN1") 
          offer = true
          price_original = total_price(cart["ids"])
          cart["ids"].push("LN1")
        end
    
        puts "-------------------------------- FINAL RESULT ----------------------------------------------------------"            
        if offer 
          puts final_score(cart, price_original)
        else
          puts final_score(cart, total_price(cart["ids"]))
        end
      end
    end
    
    
    def buy?(option)
      option == 1 ? true : false
    end
    
    def add_elements_cart(cart, option)
      case option
      when 1
        cart["ids"].push("AP1")
      when 2
        cart["ids"].push("LN1")
      when 3
        cart["ids"].push("HP1")
      end
    end
    
    def total_price(cart)
    
      cart_with_prices = {
        "AP1": 0,
        "LN1": 0,
        "HP1": 0
      }
  
      cart.each do |pc|
        case pc 
        when "AP1"
          cart_with_prices[:AP1] += 60
        when "LN1"
          cart_with_prices[:LN1] += 41
        when "HP1"
          cart_with_prices[:HP1] += 39
        end
      end
      
      # validation that if there are two or more macbook pro
      # We apply a 10% discount to these products      
      cart_with_prices[:AP1] = percentage_calculation(10, cart_with_prices[:AP1]) if cart.count("AP1") >= 2        
      cart_with_prices.values.sum
    end
    
    def percentage_calculation(percentage, price)
      price - (price * "0.#{percentage}".to_f)
    end

    def final_score(cart, final_price)
      "#{cart.to_json} \n Total price expected: #{final_price.to_s}€"
    end
end

rzilient = Rzilient.new
puts rzilient.welcome
rzilient.checkout