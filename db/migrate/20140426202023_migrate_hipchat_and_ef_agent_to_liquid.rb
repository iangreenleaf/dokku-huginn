class MigrateHipchatAndEfAgentToLiquid < ActiveRecord::Migration
  def up
    Agent.where(:type => 'Agents::HipchatAgent').each do |agent|
      LiquidMigrator.convert_all_agent_options(agent)
    end
    Agent.where(:type => 'Agents::EventFormattingAgent').each do |agent|
      agent.options['instructions'] = LiquidMigrator.convert_hash(agent.options['instructions'], {:merge_path_attributes => true, :leading_dollarsign_is_jsonpath => true})
      agent.save
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Cannot revert migration to Liquid templating"
  end
end
