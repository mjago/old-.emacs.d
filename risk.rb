# Require the WIN32OLE library
require 'win32ole'

@data = []
@hazards = []
@causes =[{'fjksdal' => 0}]
@cause_count = 1
@hazard_count = 1
	#~ ['hot water','failure of water heater'],
	#~ ['','failure of sterile connector'],
	#~ ['cold water','failure of water heater'],
	#~ ['','failure of sterile connector']
#~ ]

def get_cause_id cause
	@temp_cause_count = nil
	@causes.each do |c|
#		puts "c = #{c}"
		if c.has_key?(cause)
			@temp_cause_count = c[cause]
		   break
		 end
	end
	 
	if @temp_cause_count == nil
		@temp_cause_count = @cause_count 
		@cause_count += 1
		@causes.push({ cause => @temp_cause_count })
#			puts "@causes.inspect = #{@causes.inspect}"
	end
 @temp_cause_count
end

def hazard(*h)
	if h.size < 2
		puts 'ERROR! hazard needs a cause'
		exit 1
	end	
	temp_hazard_count = nil
	@hazard = h[0]
	@hazards.each do |h|
		if h.has_key?(@hazard)
			temp_hazard_count = h.value
		else
			temp_hazard_count = @hazard_count 
			@hazard_count  += 1
			@hazards.push({ @hazard => temp_hazard_count })
		   break
		end
	end
	
# next sort the causes per hazard...

	h.delete_at(0)
	@data.push ["H#{@hazard_count}", @hazard, "C#{get_cause_id(h[0])}", h[0]]
	@hazard_count += 1
	h.delete_at(0)
	h.each do |x|
		@data.push ['','',"C#{get_cause_id(x)}",x]
	end	
end

def write_to_spreadsheet(name)
	#puts @data.inspect
	# Create an instance of the Excel application object
	xl = WIN32OLE.new('Excel.Application')
	# Make Excel visible
	xl.Visible = 1
	# Add a new Workbook object
	wb = xl.Workbooks.Add
	# Get the first Worksheet
	ws = wb.Worksheets(1)
	# Set the name of the worksheet tab
	ws.Name = 'Sample Worksheet'
	# For each row in the data set
	@data.each_with_index do |row, r|
		# For each field in the row
		row.each_with_index do |field, c|
				# Write the data to the Worksheet
				ws.Cells(r+1, c+1).Value = field.to_s
		end
	end
	# Save the workbook
	wb.SaveAs("c:\\ruby_code\\excel\\#{name}.xls")
#	wb.SaveAs('c:\temp\workbook.xls')
	# Close the workbook
	wb.Close
	# Quit Excel
	xl.Quit
end

hazard 'hot water',
'failure of water heater',
'failure of sterile connector'

hazard 'cold water',
'failure of water heater',
'failure of sterile connector'

hazard 'acid',
'failure of dialyser',
'failure of cartridge'

hazard     'alkaline',
'failure of dialyser',
'failure of cartridge'

hazard     'high-pressure air',
'failure of hydraulic system',
'failure of valve'

hazard     'air',
'failure of bubble sensor',
'failure of bubble trap',
'failure of venous needle port'

hazard     'broken dialyser fibres',
'failure of dialyser',
'physical damage to dialyser'

hazard     'bacteria',
'bacteria entry via drain cup',
'contaminated bicarb powder',
'contaminated bicarb container',
'contaminated acid',
'contaminated water',
'contaminated saline',
're-used cartridge',
're-used blood line',
'dirty needle'

hazard     'clotted blood',
'failure of thrombus trap',
'mains supply failure',
'power-supply failure',
'peristaltic pump failure'

hazard     'venous needle falling out of arm',
'patient movement',
'high-pressure in blood line',
'over-taught blood line',
'failed attachment tape'

hazard     'venous line becoming damaged',
'patient laying on needle line',
'high-pressure in blood line',
'action of venous clamp',
'line construction failure'

hazard     'venous needle becoming blocked',
'blood clot blockage',
'foreign body blockage'

hazard     'blockage in dialyser and associated tubes',
'foreign body blockage',
'failure of dialyser'

hazard     'faulty venous clamp',
'blood line damaged by clamping action'

hazard     'faulty priming drain',
'blood loss through faulty priming drain'

hazard     'faulty needle port',
'blood loss through faulty needle port'

hazard     'broken bubble sensor',
'blood loss from broken bubble sensor'

hazard     'broken blood sensor',
'blood loss from broken blood sensor'

hazard     'broken cartridge pressure sensor',
'blood loss from broken cartridge pressure sensor'

hazard     'broken bubble trap',
'blood loss from broken bubble trap'

hazard     'broken dialyser',
'blood loss from broken dialyser'

hazard     'broken heparin syringe',
'blood syphoning via broken heparin syringe / line'

hazard     'syphoning caused by broken bladder',
'blood syphoning via broken bladder'

hazard     'live conduction via faulty earth circuit of power supply',
'faulty power supply'

hazard     'lightening strike',
'lightening strike to localised earth'

hazard     'Static to earth',
'static buildup of clothing'

hazard     'Buildup of static within dialyser',
'dialyser within electro-magnetic field'

hazard     'faulty peristaltic pump',
'faulty peristaltic pump power supply'

hazard     'faulty pressure sensor',
'faulty pressure sensor power supply'

hazard     'faulty blood sensor',
'faulty blood sensor power supply'

hazard     'faulty valve solenoid',
'faulty valve solenoid'

hazard     'faulty pump solenoid',
'faulty pump solenoid'

hazard     'excessive current induced into conductivity sensor',
'faulty conductivity sensor constant current generator'

hazard     'faulty user interface',
'faulty touch screen'

hazard     'faulty RO water supply',
'faulty RO unit'

hazard     'drain discharge coming into contact with electrical source',
'drain discharge coming into contact with electrical source'

#Blood imbalance (volume) due to...

hazard     'faulty Ultra-Filtration Pump',
'faulty Ultra-Filtration Pump'

hazard     'faulty flow balancer',
'faulty flow balancer'

hazard     'faulty dialyser',
'faulty dialyser'

hazard     'incorrect acid mix',
'incorrect acid mix'

hazard     'peristaltic pump slipping',
'peristaltic pump slipping'

hazard     'peristaltic pump running too fast',
'peristaltic pump running too fast'

hazard     'peristaltic pump running too slow',
'peristaltic pump running too slow'

hazard     'water in venous line',
'water in venous line'

hazard     'air in venous line',
'air in venous line'

hazard     'saline in arterial line',
'saline in arterial line'

hazard     'faulty pressure sensor',
'faulty pressure sensor'

hazard     'faulty blood sensor',
'faulty blood sensor'

hazard     'faulty bubble sensor',
'faulty bubble sensor'

hazard     'blood leak',
'blood leak'

hazard     'faulty de-aerator',
'faulty de-aerator'

hazard     'Acid entering blood circuit',
'faulty cartridge unit'

hazard     'Bicarb entering blood circuit',
'faulty cartridge unit'

hazard     'bacteria entering blood circuit',
'faulty cartridge unit'

hazard     'toxins entering blood circuit',
'faulty cartridge unit'

hazard     'dirty or re-used cartridge',
'dirty cartridge unit'

hazard     'dirty needles or tubing',
'dirty needles or tubing'

hazard     'faulty RO water supply',
'faulty RO water supply'

hazard     'faulty endotoxin filter',
'faulty endotoxin filter'

hazard     'drain entering blood circuit',
'faulty cartridge unit'

hazard     'contamination entry via the drain cup',
'contamination entry via the drain cup'

hazard     'faulty acid mix',
'faulty cartridge unit'

hazard     'bicarb depletion',
'bicarb used up'

hazard     'acid depletion',
'acid used up'

hazard     'bacteria entering needle port',
'faulty needle port'

hazard     'bacteria entering saline tube port',
'faulty saline tube port'

hazard     'bacteria entering faulty dialyser',
'faulty dialyser'

hazard     'bacteria entering epo needle port',
'faulty epo needle port'

hazard     'bacteria entering priming drain',
'faulty priming drain'

hazard     'bacteria entering faulty bubble sensor',
'faulty bubble sensor'

hazard     'bacteria entering faulty blood sensor',
'faulty blood sensor'

hazard     'bacteria entering faulty pressure sensor',
'faulty pressure sensor'

hazard     'bacteria entering faulty bubble trap',
'faulty bubble trap'

hazard     'bacteria entering dialysate sample port',
'faulty dialysate sample port'

hazard     'bacteria entering faulty sterile connector',
'faulty sterile connector'

hazard     'bacteria entering faulty blood leak sensor',
'faulty blood leak sensor'

hazard     'faulty endotoxin filter 2',
'faulty endotoxin filter 2'

hazard     'bacteria entering needle piercing points',
'insufficient cleansing of piercing points'

hazard     'dirty needle',
'dirty needle'

hazard     'contaminated bicarb concentrate',
'contaminated bicarb concentrate'

hazard     'contaminated saline',
'contaminated saline'

hazard     'contaminated water',
'contaminated water'

hazard     'incorrect acidity acid mix',
'incorrect acidity acid mix'

#Explosion of water boiler due to...

hazard     'faulty boiler',
'faulty boiler'

hazard     'faulty water heater control causing water temperature to rise too high',
'faulty boiler'

hazard     'faulty RO water supply',
'faulty RO water supply (high pressure)'

hazard     'blocked connection between water pump and cartridge',
'faulty sterile connector'

hazard     'drain blockage',
'blocked drainage'

#Fire due to...

hazard     'electric motor failure',
'faulty electric motor'

hazard     'pump failure',
'faulty hydraulic pump'

hazard     'solenoid failure',
'faulty solenoid'

hazard     'power supply failure',
'faulty power-supply'

hazard     'boilure failure',
'faulty boiler'

hazard     'wiring failure',
'electric-short in wiring'

#Damage to user by unit falling ...

hazard     'patient attachment to unit pulls unit over',
'involuntary movement during sleep'

hazard     'broken wheel/leg/stand',
'faulty haemodialyser wheel/leg/stand'

hazard     'weight of concentrates or saline causes mis-balance',
'weight of concentrates or saline causes mis-balance'

hazard     'mains supply lead is tripped over causing unit to fall',
'inadvertant stain on mains lead'

hazard     'pressure of user touch on user controls pushes unit over',
'heavy user touch on haemodialyser'

#Poisoning of user by oral intake...

hazard     'ingestion of acid concentrate',
'curious child'

hazard     'ingestion of bicarbonate preparation',
'curious child'

hazard     'ingestion of heparin',
'curious child'

hazard     'ingestion of drain substance',
'curious child'

#Harm to user due to mis-diagnosis and subsequent mis-treatment...

#Harm to user due to biocompatibility...'

hazard     'faulty line-set',
'line-set manufacture fault'

hazard     'faulty dialyser',
'dialyser manufacture fault'

hazard     'faulty needle',
'needle manufacture fault'

hazard     'contaminated saline',
'saline manufacture fault'

hazard 	  'failure of software',
'failure of software library',
'change in output format of software',
'change in input format of software'

#puts @data.inspect

write_to_spreadsheet('test')
