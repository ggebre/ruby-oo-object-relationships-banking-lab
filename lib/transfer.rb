require "pry"
class Transfer
  # your code here
  
  attr_accessor :sender, :receiver, :amount, :status
  attr_accessor :transfered
  def initialize (sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    # persists the amount to transfered for reversing transaction
    @transfered = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    # checks if the sender has an open account and balance greater than the transfer amount 
    if valid? && self.sender.balance > amount   
        self.sender.balance -= self.amount
        self.receiver.balance += self.amount
        self.status = "complete"
        self.amount = 0
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
    
  end
  def reverse_transfer
    if self.status == "complete"
      self.sender.balance += self.transfered
      self.receiver.balance -= self.transfered
      self.status = "reversed"
    end
  end
end
