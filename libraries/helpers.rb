class Chef
  module OpslineUsers
    module Helpers

      def _get_databag_item(databag_name, item_name)
        item = Chef::DataBagItem.load(databag_name, item_name).to_hash
        item.each do |k, v|
          next if k == 'id'
          if item[k].respond_to?('key?') && item[k].key?('encrypted_data')
            item = Chef::EncryptedDataBagItem.load(databag_name, item_name).to_hash
            break
          end
        end
        item
      end

      def get_all_groups()
        data_bag(node['opsline-users']['groups_databag_name'])
      end

      def get_all_users()
        data_bag(node['opsline-users']['users_databag_name'])
      end

      def get_group(group_name)
        g = _get_databag_item(node['opsline-users']['groups_databag_name'], group_name)
        g['action'] = 'create' unless g.key?('action')
        g
      end

      def get_user(user_name)
        u = _get_databag_item(node['opsline-users']['users_databag_name'], user_name)
        u['action'] = 'create' unless u.key?('action')
        u['groups'] = [] unless u.key?('groups')
        u
      end

      # validate action
      # return valid action symbol
      # fail if invalid action
      def validate_action(action)
        case action
        when 'create'
          return :create
        when 'remove'
          return :remove
        when 'lock'
          return :lock
        else
          Chef::Application.fatal!("opsline-user: unsupported action in databag: '#{action}'")
        end
      end

      # validate id
      # return Integer when it parses, string otherwise
      def validate_id(id)
        id.to_i.to_s == id ? id.to_i : id
      end

    end
  end
end
