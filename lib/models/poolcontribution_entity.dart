import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PoolcontributionEntity with JsonConvert<PoolcontributionEntity> {
	@JSONField(name: "team_amount")
	String teamAmount;
	@JSONField(name: "genera_power")
	String generaPower;
	@JSONField(name: "genera_award")
	String generaAward;
	@JSONField(name: "process_award")
	String processAward;
	@JSONField(name: "miners_team")
	String minersTeam;
	@JSONField(name: "best_keep_limit")
	String bestKeepLimit;
	@JSONField(name: "min_keep_limit")
	String minKeepLimit;
}
