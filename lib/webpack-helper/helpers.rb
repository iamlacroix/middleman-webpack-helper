module WebpackHelper
  module Helpers

    def webpack_url(filename)
      asset = find_asset_by_id(filename)
      [ public_path, asset[:fullname] ].join('/')
    end

    private

    # Lookup asset in the assets hash
    def find_asset_by_id(id)
      assets[id]
    end

    # Lookup the public path and remove the trailing forward slash
    def public_path
      stats['publicPath'].gsub(/\/$/, '')
    end

    def stats
      @stats ||= get_stats
    end

    def assets
      @assets_hash ||= generate_asset_hash
    end

    def options
      extensions[:webpack_helper].options
    end

    def get_stats
      stats_path = options.stats_path

      unless stats_path
        raise '`stats_path` option must be set for the `webpack_helper` ' +
              'Middleman extension.'
      end

      stats_file = File.read(stats_path)
      JSON.parse(stats_file)
    end

    def generate_asset_hash
      regex = Regexp.new '(?<hashname>.+)\.(?<ext>css|js)$'
      assets = {}

      stats['assets'].each do |asset|
        matches = regex.match(asset['name'])
        _, hashname, ext = matches.to_a

        simplename = asset['chunkNames'][0]
        fullname = "#{hashname}.#{ext}"
        id = "#{simplename}.#{ext}"

        if hashname && ext && simplename
          assets[id] = {
            id: id,
            fullname: fullname,
            hashname: hashname,
            name: simplename,
            ext: ext,
          }
        end
      end

      assets
    end

  end
end
