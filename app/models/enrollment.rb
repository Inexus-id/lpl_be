class Enrollment < ActiveRecord::Base
  attr_accessible :birt, :dni_l, :dni_n, :first_name, :hardware, :last_name, :nick, :email, :clan_attributes, :tournament_ids
  belongs_to :clan
  belongs_to :etype
  has_many :participations
  has_many :tournaments, through: :participations
  validates_presence_of :birt, :dni_l, :dni_n, :first_name, :last_name, :email
  validates_uniqueness_of :dni_n, :email
  validate :pc_count
  validate :video_game_count
  accepts_nested_attributes_for :clan

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def age
    age = Date.today.years_ago(self.birt.year).year
    if self.birt.day < Date.today.day and self.birt.month < Date.today.month
      age -= 1
    end
    age
  end

  def dni
    self.dni_n.to_s + self.dni_l
  end

  def pc_count
    if self.tournaments.where(pc: true).count >= 2
      errors.add(:tournaments, "No puedes incribirte en mas de dos competiciones de pc.")
    end
  end
  def video_game_count
    if self.tournaments.where(pc: false).count >= 2
      errors.add(:tournaments, "No puedes incribirte en mas de dos competiciones de consola.")
    end
  end

  def pay
    self.update_attribute(:paid_at, Time.now)
  end

  def unpay
    self.update_attribute(:paid_at, nil)
  end
end