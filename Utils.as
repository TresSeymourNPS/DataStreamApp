package maca.utils {
  /**
	 * MACA methods that may prove useful.
	 * 
	 * @author	Bluecadet, Stephen Hurwitz <steve@bluecadet.com>
	 * @author  MACA, Tres Seymour <Tres_Seymour@nps.gov>
	 * @package	maca.utils.view
	 */

	public class Utils {
		
		public function Utils(){}
		
		/**
		 * Convert MACA system speed to miles per hour
		 * 
		 * @param Number speed
		 * @return int
		 */
		public static function speedToMPH(speed:Number):int {
			//return speed * 10;
			/**
			 * Speed is already being returned in mph
			 */
			return speed;
		}
		
		/**
		 * Convert MACA's timestamp to Date Object
		 * 
		 * @param String timestamp
		 * @return Date
		 */
		public static function timestampToDate(timestamp:String):Date {
			/**
			 * Converts the timestamp into standard parameters
			 * for the Date Object constructor by isolating
			 * and eliminating the time zone, converting all
			 * other separting characters to hyphens,
			 * and then converting the string to an array
			 * by splitting along the hyphens.  The resulting
			 * array values correspond to the order of the
			 * parameters for the Date Object constructor,
			 * i.e., FullYear, Month, Date, Hours, Minutes, Seconds.
			 **/
			if (timestamp == '') {
				return null;
			}
			
			var dateStr:String = timestamp;
			var pattern1:RegExp = /-(\d+:\d+)/g;
			var pattern2:RegExp = /-|T|:/g;
			var match:String = (dateStr.match(pattern1)).toString();
			var tza:int = 0;
			switch (match) {
				case '-05:00':
				tza = -1;
				break;
				case '-06:00':
				tza = 0;
				break;
				case '-07:00':
				tza = 1;
				break;
				default:
				tza = 0;
				break;
			}
			dateStr = dateStr.replace(pattern1, "");
			dateStr = dateStr.replace(pattern2, "-");
			var date:Array = dateStr.split('-');
			var month:String = String((int(date[1]) - 1));
			var hour:String = String((int(date[3])+ tza));
			return new Date(date[0], month, date[2], hour, date[4], date[5]);
		}
		
		/**
		 * Format Date as String
		 * 
		 * @param Date
		 * 
		 * @return String n/j/Y | gpm
		 */			
		public static function dateToFormattedString(date:Date):String {

		var month:String = String([date.month + 1]);
		var day:String = String(date.date);
		var year:String = String(date.fullYear);
		var hour:String = (date.hours < 13) ? String(date.hours) : String(int((date.hours) - 12));
		var meridian:String = (date.hours + 1 < 12) ? 'am' : 'pm';
		return month + '/' + day + '/' + year + ' | ' + hour + ' ' + meridian + '  CT';
		}
		
		/**
		* Format Date as String
		* 
		* @param Date
		* 
		* @return String M. n
		*/
		public static function dateToShortFormattedString(date:Date, granularity:String = 'day'):String {
		var months:Array = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
		var result:String;
		
		switch (granularity) {
			case 'month':
			result = String(months[date.month]);
			break;
			case 'year':
			result = String(date.fullYear);
			break;
			default:
			result = String(months[date.month] + '. ' + date.date);
			break;
		}
		return result;
		}
		
		/**
		* Searches string for subscript tags. Will only return first instance.
		* 
		* @param String haystack
		* 
		* @return Object result and text within result
		*/
		public static function searchForSubscript(haystack:String):Object {
		var regex:RegExp = /<sub>(.*?)<\/sub>/g;
		return regex.exec(haystack);
		}
		
		/**
		* Takes string and returns an array to be used for graphs
		* 
		* @param String 
		*   examples: 'day', 'year', '2 year'
		* 
		* @return Array [int, String]
		*/
		public static function processInterval(string:String):Array {
		var result:Array = string.split(' ');
		if (result.length == 1) {
		result = [1, result[0]];
		}
		return result;
		}
		
		/**
		* Converts wind direction from degrees to "in" or "out" depending on area of cave
		 * 
		 * @param integer deg
		 * @param string cave
		 */
		public static function windDirection(deg:int, cave:String = null):String {
			var entranceInRange:Array = new Array([0, 15],[195, 360]);
			var gothicInRange:Array = new Array([0, 90],[270, 360]);
			
			if (cave == 'Gothic') {
				if (deg >= gothicInRange[0][0] && deg <= gothicInRange[0][1]) {
					return 'IN';
				}
				if (deg >= gothicInRange[1][0] && deg <= gothicInRange[1][1]) {
					return 'IN';
				}
			}
			else {
				if (deg >= entranceInRange[0][0] && deg <= entranceInRange[0][1]) {
					return 'IN';
				}
				if (deg >= entranceInRange[1][0] && deg <= entranceInRange[1][1]) {
					return 'IN';
				}
			}
			
			return 'OUT';
		}
	}
}
