require_relative './test_helper'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new

    assert_instance_of TransactionRepository, tr
  end

  def test_it_can_find_all_transactions
    tr = TransactionRepository.new
    t1 = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    tr.add_individual_item(t1)
    assert_equal [t1], tr.all
  end

  def test_it_can_find_by_id
    tr = TransactionRepository.new
    t1 = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    t2 = Transaction.new({
      :id => 3,
      :invoice_id => 750,
      :credit_card_number => "4271805778010747",
      :credit_card_expiration_date => "1220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    t3 = Transaction.new({
      :id => 9,
      :invoice_id => 1752,
      :credit_card_number => "4463525332822998",
      :credit_card_expiration_date => "0618",
      :result => "failed",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    tr.add_individual_item(t1)
    tr.add_individual_item(t2)
    tr.add_individual_item(t3)
    assert_equal t3, tr.find_by_id(9)
  end

  def test_it_can_find_all_by_invoice_id
    tr = TransactionRepository.new
    t1 = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    t2 = Transaction.new({
      :id => 3,
      :invoice_id => 750,
      :credit_card_number => "4271805778010747",
      :credit_card_expiration_date => "1220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    t3 = Transaction.new({
      :id => 9,
      :invoice_id => 1752,
      :credit_card_number => "4463525332822998",
      :credit_card_expiration_date => "0618",
      :result => "failed",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    tr.add_individual_item(t1)
    tr.add_individual_item(t2)
    tr.add_individual_item(t3)
    assert_equal [t2], tr.find_all_by_invoice_id(750)
  end

  def test_it_can_find_all_by_credit_card_number
    tr = TransactionRepository.new
    t1 = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    t2 = Transaction.new({
      :id => 3,
      :invoice_id => 750,
      :credit_card_number => "4271805778010747",
      :credit_card_expiration_date => "1220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    t3 = Transaction.new({
      :id => 9,
      :invoice_id => 1752,
      :credit_card_number => "4463525332822998",
      :credit_card_expiration_date => "0618",
      :result => "failed",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    tr.add_individual_item(t1)
    tr.add_individual_item(t2)
    tr.add_individual_item(t3)
    assert_equal [t3], tr.find_all_by_credit_card_number("4463525332822998")
  end

  def test_it_can_find_all_by_result
    tr = TransactionRepository.new
    t1 = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    t2 = Transaction.new({
      :id => 3,
      :invoice_id => 750,
      :credit_card_number => "4271805778010747",
      :credit_card_expiration_date => "1220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    t3 = Transaction.new({
      :id => 9,
      :invoice_id => 1752,
      :credit_card_number => "4463525332822998",
      :credit_card_expiration_date => "0618",
      :result => "failed",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    tr.add_individual_item(t1)
    tr.add_individual_item(t2)
    tr.add_individual_item(t3)
    assert_equal [t1,t2], tr.find_all_by_result("success")
  end

  def test_it_can_create_transaction
    tr = TransactionRepository.new

    tr.create({
      :invoice_id => 21,
      :credit_card_number => "446050003000999",
      :credit_card_expiration_date => "0121",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    actual = tr.find_by_id(1).invoice_id
    assert_equal 21, actual

    tr.create({
      :id => 9,
      :invoice_id => 1752,
      :credit_card_number => "4463525332822998",
      :credit_card_expiration_date => "0618",
      :result => "failed",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    actual = tr.find_by_id(9).invoice_id
    assert_equal 1752, actual

    tr.create({
      :id => 9,
      :invoice_id => 2001,
      :credit_card_number => "446050003000008",
      :credit_card_expiration_date => "0721",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    actual = tr.find_by_id(10).invoice_id
    assert_equal 2001, actual
  end


    def test_it_can_update_transaction
      tr = TransactionRepository.new
      t1 = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "failed",
        :created_at => Time.now,
        :updated_at => Time.now
      })
      tr.add_individual_item(t1)

      updates = {
        :id => 3,
        :invoice_id => 750,
        :credit_card_number => "4271805778010747",
        :credit_card_expiration_date => "1220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
        }
      tr.update(6, updates)

      assert_equal "4271805778010747", t1.credit_card_number
      assert_equal "1220", t1.credit_card_expiration_date
      assert_equal "success", t1.result
      refute_equal 750, t1.invoice_id
    end

    def test_it_can_delete_transactions
      tr = TransactionRepository.new
      t1 = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      })
      t2 = Transaction.new({
        :id => 3,
        :invoice_id => 750,
        :credit_card_number => "4271805778010747",
        :credit_card_expiration_date => "1220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      })
      tr.add_individual_item(t1)
      tr.add_individual_item(t2)
      tr.delete(3)

      assert_nil tr.find_by_id(3)
    end

    def test_it_can_split_csv
      tr = TransactionRepository.new("./data/transactions_test.csv")

      assert_equal 10, tr.all.length

      assert_equal 1, tr.all.first.id
      assert_equal 10, tr.all.last.id
    end


end
