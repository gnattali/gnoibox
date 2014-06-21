module Gnoibox
  module Axis::Type
    module Prefecture
      extend ActiveSupport::Concern

      included do

        SEED = {
          "01"=> %w(北海道 北海道 hokkaido hk A),
          "02"=> %w(青森 青森県 aomori am B),
          "03"=> %w(岩手 岩手県 iwate it C),
          "04"=> %w(宮城 宮城県 miyagi mg D),
          "05"=> %w(秋田 秋田県 akita at E),
          "06"=> %w(山形 山形県 yamagata ym F),
          "07"=> %w(福島 福島県 fukushima fs G),
          "08"=> %w(茨城 茨城県 ibaraki ig H),
          "09"=> %w(栃木 栃木県 tochigi tg I),
          "10"=> %w(群馬 群馬県 gunma gm J),
          "11"=> %w(埼玉 埼玉県 saitama st K),
          "12"=> %w(千葉 千葉県 chiba cb L),
          "13"=> %w(東京 東京都 tokyo tk M),
          "14"=> %w(神奈川 神奈川県 kanagawa kn N),
          "15"=> %w(新潟 新潟県 niigata ng O),
          "16"=> %w(富山 富山県 toyama ty P),
          "17"=> %w(石川 石川県 ishikawa ik Q),
          "18"=> %w(福井 福井県 fukui fk R),
          "19"=> %w(山梨 山梨県 yamanashi yn S),
          "20"=> %w(長野 長野県 nagano nn T),
          "21"=> %w(岐阜 岐阜県 gifu gf U),
          "22"=> %w(静岡 静岡県 shizuoka so V),
          "23"=> %w(愛知 愛知県 aichi ac W),
          "24"=> %w(三重 三重県 mie me X),
          "25"=> %w(滋賀 滋賀県 shiga sg Y),
          "26"=> %w(京都 京都府 kyoto kt Z),
          "27"=> %w(大阪 大阪府 osaka os a),
          "28"=> %w(兵庫 兵庫県 hyogo hg b),
          "29"=> %w(奈良 奈良県 nara nr c),
          "30"=> %w(和歌山 和歌山県 wakayama wk d),
          "31"=> %w(鳥取 鳥取県 tottori tt e),
          "32"=> %w(島根 島根県 shimane sn f),
          "33"=> %w(岡山 岡山県 okayama oy g),
          "34"=> %w(広島 広島県 hiroshima hs h),
          "35"=> %w(山口 山口県 yamaguchi yg i),
          "36"=> %w(徳島 徳島県 tokushima to j),
          "37"=> %w(香川 香川県 kagawa ka k),
          "38"=> %w(愛媛 愛媛県 ehime eh l),
          "39"=> %w(高知 高知県 kochi ko m),
          "40"=> %w(福岡 福岡県 fukuoka fo n),
          "41"=> %w(佐賀 佐賀県 saga sa o),
          "42"=> %w(長崎 長崎県 nagasaki ns p),
          "43"=> %w(熊本 熊本県 kumamoto km q),
          "44"=> %w(大分 大分県 oita ot r),
          "45"=> %w(宮崎 宮崎県 miyazaki mz s),
          "46"=> %w(鹿児島 鹿児島県 kagoshima kg t),
          "47"=> %w(沖縄 沖縄県 okinawa on u),
          "48"=> %w(海外 海外 oversea zz 0)
        }

        SEED.each do |k, v|
          set_option v[2], v[0], {full_text: v[1], abbr: v[3], prefecture_id: k.to_i.to_s}
        end

      end

      module ClassMethods
        def type() :prefecture end
      
        def full_text_hash
          @full_text_hash ||= options.index_by{|o| o.settings[:full_text]}
        end
        
        def full_text_list
          full_text_hash.keys
        end
        
        def tag_for(v)
          full_text_list.detect do |t|
            break full_text_hash[t].key if v.index(t)==0
          end
        end

      end

    end
  end
end
