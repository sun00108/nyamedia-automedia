class Media < ApplicationRecord
  belongs_to :torrent

  #before_save :set_name_cn

  def self.search(params)
    medias = all
    adapter_type = ActiveRecord::Base.connection.adapter_name.downcase

    # 字符串类型的字段，使用ILIKE或LIKE进行不区分大小写的模糊查询
    string_attributes = %i[name quality source source_type video_codec audio_codec]
    string_attributes.each do |attribute|
      if params[attribute].present?
        case adapter_type
        when 'postgresql'
          medias = medias.where("CAST(#{attribute} as TEXT) ILIKE ?", "%#{params[attribute]}%")
        else
          medias = medias.where("LOWER(#{attribute}) LIKE ?", "%#{params[attribute].downcase}%")
        end
      end
    end

    # 整数类型的字段，使用精确匹配
    integer_attributes = %i[season episode year]
    integer_attributes.each do |attribute|
      medias = medias.where(attribute => params[attribute]) if params[attribute].present?
    end

    # 查询 medias 中每一个 media 的 torrent 的状态
    medias = medias.select('media.*, torrents.status AS torrent_status').joins(:torrent)
    medias
  end

  private

  # def set_name_cn
  #   if self.name_cn.blank?
  #     existing_media = Media.find_by(name: self.name)
  #     unless existing_media.blank?
  #       unless existing_media.name_cn.blank?
  #         self.name_cn = existing_media.name_cn
  #       end
  #     end
  #   end
  # end
end
