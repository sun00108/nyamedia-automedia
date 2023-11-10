class Torrent < ApplicationRecord
  belongs_to :rss_feed
  has_one :media
  validates :guid, uniqueness: true
  enum status: {
    pending: 0,
    downloaded: 1
  }

  # 刮削标题
  def scrape
    # 正则表达式
    year_regex = /\b\d{4}\b/
    #season_episode_regex = /(?:S(\d+))?(?:E(\d+))?/i
    season_episode_regex = /S(\d+)(?:E(\d+))?/i # 修改这里，使E(\d+)变成可选
    quality_regex = /\b(1080p|720p|2160p|480p|4K)\b/i
    source_type_regex = /(WEB-DL|BluRay)/i
    source_name_regex = /\b(Baha|CR|KKTV|B-Global|Abema|Viu)\b/i
    video_codec_regex = /\b(x264|x265|AVC|HEVC|H264|H265)\b/i
    audio_codec_regex = /\b(AAC|LPCM|AC3|DTS)\b/i

    result = {}

    # 去掉括号内的内容
    name = self.title.gsub(/\[.*?\]/, '').strip

    # 查找第一个信息点的位置
    first_info_point = [
      season_episode_regex,
      year_regex,
      quality_regex,
      source_type_regex,
      source_name_regex,
      video_codec_regex,
      audio_codec_regex
    ].map { |regex| name.index(regex) }.compact.min

    # 提取ResourceName
    resource_name = first_info_point ? name[0...first_info_point].strip : name

    # 提取其他信息
    if match = name.match(season_episode_regex)
      season = match[1]
      episode = match[2]
    end
    if match = name.match(year_regex)
      year = match[0]
    end
    if match = name.match(quality_regex)
      quality = match[0]
    end
    if match = name.match(source_type_regex)
      source_type = match[0]
    end
    if match = name.match(source_name_regex)
      source_name = match[0]
    end
    if match = name.match(video_codec_regex)
      video_codec = match[0]
    end
    if match = name.match(audio_codec_regex)
      audio_codec = match[0]
    end

    # 在这里，你可以使用 result 中的信息来创建或更新关联的 media 对象
    media = self.media || self.build_media
    media.update(name: resource_name, season: season, episode: episode, year: year, quality: quality, source: source_name, source_type: source_type, video_codec: video_codec, audio_codec: audio_codec)
  end

  # 下载种子
  def download

    begin
      response = TransmissionService.add_uri(self.magnet)
      print(response.to_yaml)
      self.status = 'downloaded'
      save
      TelegramService.broadcast("【正在下载】 #{media.name} - S#{media.season}E#{media.episode}")
    rescue
      TelegramService.broadcast("【下载失败】 #{media.name} - S#{media.season}E#{media.episode}")
    end
  end

end
