require_relative './item'
require_relative './merchant'
require 'pry'

class ItemRepository
    attr_reader :all

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
  end

  def add_individual_item(item)
    @all << item
  end

  def split(filepath)
    item_objects = CSV.open(filepath, headers: true, header_converters: :symbol)

    item_objects.map do |object|
      object[:id] = object[:id].to_i

      @attributes_array << object.to_h
    end
    @attributes_array.map do |hash|
      @all << Item.new(hash)
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price.to_f == price.to_f
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id.to_i
    end
  end

  def create(attributes)
    if @all == []
      new_id = 1
    else
      highest_id = @all.max_by do |item|
        item.id
      end.id
      new_id = highest_id + 1
    end
    attributes[:id] = new_id
    @all << Item.new(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    item.name = attributes[:name]
    item.description = attributes[:description]
    item.unit_price = attributes[:unit_price]
    item.updated_at = Time.now
  end

  def delete(id)
    item = find_by_id(id)
    @all.delete(item)
  end



    # def find_all_by(attr_sym, search_string)
    #   @items.find_all do |item|
    #     item[:data][attr_sym] == search_string.downcase
    #   end
    # end
    #
    # def find_by(attr_sym, search_string)
    #   @items.find do |item|
    #     item[attr_sym] == search_string.downcase
    #   end
    # end





end
