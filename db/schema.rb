# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_10_30_024930) do

  create_table "media", force: :cascade do |t|
    t.string "name"
    t.integer "season"
    t.integer "episode"
    t.integer "year"
    t.string "quality"
    t.string "source"
    t.string "source_type"
    t.string "video_codec"
    t.string "audio_codec"
    t.integer "torrent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["torrent_id"], name: "index_media_on_torrent_id"
  end

  create_table "rss_feeds", force: :cascade do |t|
    t.string "url", null: false
    t.integer "site_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id"], name: "index_rss_feeds_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name", null: false
    t.integer "architecture", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.text "filter_params"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "torrents", force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.string "magnet", null: false
    t.string "guid", null: false
    t.integer "status", default: 0, null: false
    t.integer "rss_feed_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guid"], name: "index_torrents_on_guid", unique: true
    t.index ["rss_feed_id"], name: "index_torrents_on_rss_feed_id"
  end

  add_foreign_key "media", "torrents"
  add_foreign_key "rss_feeds", "sites"
  add_foreign_key "torrents", "rss_feeds"
end
