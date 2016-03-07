class Chef
  module OpslineUsers
    module Helpers

      def _get_databag_item(databag_name, item_name)
        item = Chef::DataBagItem.load(databag_name, item_name).to_hash
        if item['type'].respond_to?('has_key?') && item['type'].has_key?('encrypted_data')
          item = Chef::EncryptedDataBagItem.load(databag_name, item_name).to_hash
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
        g['action'] == 'create' unless g.has_key?('action')
        g
      end

      def get_user(user_name)
        u = _get_databag_item(node['opsline-users']['users_databag_name'], user_name)
        u['action'] == 'create' unless u.has_key?('action')
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
        else
          Chef::Application.fatal!('opsline-user: unsupported action in databag')
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