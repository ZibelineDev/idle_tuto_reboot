extends VBoxContainer


func _ready() -> void :
	_update_value()
	ManagerMarket.ref.get_timer().timeout.connect(_on_market_timer_timeout)
	(%Description as Label).text = ManagerMarket.ref.get_log().get_description()
	
	(%X1Button as Button).pressed.connect(func() -> void : ManagerLog.ref.sell_log(1))
	(%X10Button as Button).pressed.connect(func() -> void : ManagerLog.ref.sell_log(10))
	(%X100Button as Button).pressed.connect(func() -> void : ManagerLog.ref.sell_log(100))
	(%XAllButton as Button).pressed.connect(func() -> void : ManagerLog.ref.sell_all())


func _update_value() -> void : 
	(%Value as Label).text = "%s : Silver" %StringFormat.thousands_sep(
		ManagerMarket.ref.get_log().get_value()
	)


func _on_market_timer_timeout() -> void : 
	_update_value()
