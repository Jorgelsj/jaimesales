class Sale < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :discount
  has_many :product_quantities
  has_one :comission

    after_save  do
    	calc = 0
    	#Soma o preco dos productos vezes a quantidade deles 	
    	self.product_quantities.each {|p| calc += p.product.price * p.quantity}
    	# Verifica se esiste um desconto e aplica caso exista
    	if self.discount
    		if self.discount.kind == "porcent"
    			calc -= calc / self.discount.value
    		elsif self.discount.kind == "money"
    			calc -= self.discount.value
    		end
    	end 

    	#Verifica se ja existe uma omissao, caso sim atualiza, caso nao cria uma nova
    	if self.comission.present?
    		self.comission.update(value: (calc * 0-1), status: :pending)
  	else
  		Comission.create(value: (calc * 0-1), user: self.user, sale: self, status: :pending)
  	end
  end
end
