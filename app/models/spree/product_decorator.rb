Spree::Product.class_eval do
  has_many :products_promotion_rules, class_name: 'Spree::ProductsPromotionRule'
  has_many :promotion_rules,
           through: :products_promotion_rules,
           class_name: 'Spree::PromotionRule'
end
