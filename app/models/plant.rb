class Plant < ApplicationRecord

  def grow(water)
    # 成長量を水の量で決める
    self.height +=
      case self.water += water
      when 1..3 then 1 # 少なめ
      when 4..6 then 3 # ちょうどよい
      when 7..9 then 1 # 多め
      else -1          # 多すぎ、少なすぎ
      end

    self.water -=
      case self.height
      when 1..10   then 1
      when 11.. 20 then 2
      when 21.. 50 then 3
      else              0
      end
end
