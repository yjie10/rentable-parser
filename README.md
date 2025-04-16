# Rentable Property Importer

This is a small Rails app designed to parse a property listing XML file, filter for properties located in Madison, and store the relevant data in a database. A simple Tailwind-styled UI is included for browsing the imported properties.

## 🛠️ Tech Stack

- Ruby 3.2.2
- Rails 7.1.5
- Nokogiri (for XML parsing)
- Tailwind CSS (via CDN)

> 💡 Ruby version can be managed using tools like [rbenv](https://github.com/rbenv/rbenv) or [asdf](https://asdf-vm.com/) – use whichever you prefer as long as the version matches.

---

## 🚀 Getting Started

1. Install dependencies

```bash
$ bin/rails bundle install
```

2. Create database & run migration

```bash
$ bin/rails db:create
$ bin/rails db:migrate
```

3. Start the rails server

```bash
$ bin/rails server
```

## 📦 XML Import

To import a property feed XML file, follow the steps below:

1. Open Rails console from your terminal:

```bash
$ bin/rails console
```

1. Inside the console, run the following command:

```ruby
XmlImporter.new(lib/assets/your_file.xml).import
```

> 💡 It's recommended to place the XML file under lib/assets/ for clarity and consistency. Only properties located in Madison will be imported. Duplicate properties (based on property_id) will be automatically skipped.

## 🎨 UI Overview

The application displays all imported properties as individual cards on the `/properties` page. Each `Property` is rendered with:

- A clickable property name that links to its detail view (`/properties/:id`)
- The property’s email address
- A light-weight, gray-toned `Property ID` for reference

The cards are styled using Tailwind CSS with padding, border, shadow, and rounded corners to create a clean, modern layout.

The show page provides a simplified view of the selected property, using the same visual theme for consistency.

## 🤔 Design Decisions

### 🧱 UI Layout

- Chose card-style components to improve readability and provide a modern look
- Avoided a traditional HTML table to make the layout more flexible and mobile-friendly
- Used Tailwind utility classes instead of components to keep things lightweight and simple

### 🧭 Navigation

- Linked property names to the detail page using `link_to`
- Applied Tailwind’s hover underline effect to make links feel more interactive

### ✨ Styling Choices

- Used white background, rounded corners, and soft shadows for a clean and accessible UI
- Applied Tailwind spacing (`px`, `py`, `gap`, `mt`) to ensure the layout didn’t feel cramped

## 🌟 Extra Credit: Bedroom Count Extraction

In addition to the required fields, this project also parses the number of bedrooms per property.

Each property may contain multiple `FloorPlan` entries, and each floorplan includes several `Room` elements, such as `RoomType="Bedroom"` and `RoomType="Bathroom"`. For each bedroom-type room, the `Count` value is extracted, and the **maximum** bedroom count across all floorplans is stored.

For example:

```xml
<Room RoomType="Bedroom">
  <Count>3.0</Count>
</Room>
```

This field is added as a new column (bedrooms) to the properties table and can optionally be shown in the UI.

The maximum bedroom count is chosen to represent the most spacious unit available for that property.

## 🌟 Extra Credit: Run Background Import via Rake

If you'd like to trigger the background import via a rake task, run the following command:

```bash
$ bin/rails import:feed
```

This command enqueues an `ImportPropertyFeedJob` to process the default XML file (`lib/assets/sample_abodo_feed.xml`).

Make sure the file path matches your local setup. You can customize the rake task to change the file path if needed.

> 💡 **Note:** In `development`, this project uses `config.active_job.queue_adapter = :inline` to ensure background jobs run **synchronously**. This avoids potential issues where the default `:async` adapter may silently fail to execute jobs triggered via rake tasks or outside of a running server process.

This setting is configured in `config/environments/development.rb`:

```ruby
# run background jobs inline in development for more predictable behavior
config.active_job.queue_adapter = :inline
```

_P.S. This was my first time writing a custom rake task and connecting it with Active Job. I've used rake before, but this was the first time I actually defined and triggered a job myself, and it turned out to be simpler than I expected._

_Thanks for reading! This was a fun little challenge to work on, and it gave me a chance to brush up on XML, Tailwind, background jobs, and even a bit of Rails rake internals, all in one go._ 🐾
