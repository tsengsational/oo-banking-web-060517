require 'pry'
class Transfer
attr_accessor :sender, :receiver, :status, :amount

@@transfers = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    if self.sender.valid? == true && self.receiver.valid? == true
      @@transfers << self
      return true
    else
      return false
    end
  end

  def execute_transaction
    # binding.pry
    if self.sender.valid? == false || self.sender.balance < self.amount
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    elsif self.status == "complete" || @@transfers.include?(self)
      return "This transaction has already been executed."
    elsif self.status == "pending" && !@@transfers.include?(self)
        @@transfers << self
        self.sender.balance -= self.amount
        self.receiver.balance += self.amount
        self.status = "complete"
    end
  end

def reverse_transfer
  if self.status == "complete" && @@transfers.include?(self)
    self.sender.balance += self.amount
    self.receiver.balance -= self.amount
    self.status = "reversed"
  end
end

end
