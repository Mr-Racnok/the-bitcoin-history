//@version=5
indicator("The Bitcoin History", overlay=true)
pesan = input.string("IJAH", title="Terima kasih bagi kamu yang sudah menggunakan & share indikator ini." + "\n Indikator ini hanya bekerja maksimal pada timeframe 1 Hari." + "\n Mengapa ? dikarenakan tradingview memiliki limit bar yang bisa dikoneksikan.")
trade_settings = input.string("", title="────────── Trade Settings ──────────")
leverage = input.float(1.0, title="Leverage (Max 200)", minval=1, maxval=200)
fee = input.float(0.05, title="fee (Max 1)", minval=0.00, maxval=1)
color_settings = input.string("", title="────────── Color Settings ──────────")
label_must_buy_bg = input.color(color.rgb(100, 232, 255, 70),"Fear")
label_halving_bg = input.color(color.rgb(255, 255, 100, 70),"Halving")
default_forecolor = input.color(color.white,"Default Text")
table_header_bg = input.color(color.rgb(255,255,255,80),"Table Header Background")
table_bg = input.color(color.rgb(255,255,255,90),"Table Data Background")
table_forecolor = input.color(color.rgb(255,255,255,50),"Table Text")
box_profit_bg = input.color(color.rgb(100, 255, 100, 90),"Box Profit Background")
box_loss_bg = input.color(color.rgb(255,100,100,90),"Box Loss Background")
label_buy_bg = input.color(color.rgb(100, 255, 100, 70),"Label Buy/Profit")
label_sell_bg = input.color(color.rgb(255, 100, 100, 70),"Label Sell/Loss")
table_profit_forecolor = label_buy_bg
table_loss_forecolor = label_sell_bg
table_ongoing_forecolor = input.color(color.rgb(255, 183, 100, 11),"Label Sell/Loss")

halving_dates = array.new_int()
array.push(halving_dates, timestamp("2009-01-03 00:00"))
array.push(halving_dates, timestamp("2012-11-28 00:00"))
array.push(halving_dates, timestamp("2016-07-09 00:00"))
array.push(halving_dates, timestamp("2020-05-11 00:00"))
array.push(halving_dates, timestamp("2024-04-20 00:00"))

days_of_B1 = 940 * 86400 * 1000
days_of_S1 = 242 * 86400 * 1000
days_of_B2 = 261 * 86400 * 1000
days_of_S2 = 286 * 86400 * 1000
days_of_B3 = 293 * 86400 * 1000
days_of_S3 = 306 * 86400 * 1000
days_of_B4 = 318 * 86400 * 1000
days_of_S4 = 339 * 86400 * 1000
days_of_B5 = 349 * 86400 * 1000
days_of_S5 = 362 * 86400 * 1000
days_of_B6 = 433 * 86400 * 1000
days_of_S6 = 483 * 86400 * 1000
days_of_B7 = 505 * 86400 * 1000
days_of_S7 = 546 * 86400 * 1000
days_of_B8 = 621 * 86400 * 1000
days_of_S8 = 686 * 86400 * 1000
days_of_pump_halving = 162 * 86400 * 1000

currentTF = int(str.tonumber(timeframe.period))
var int nilaiTF = 1440 / currentTF
B1_to_S1 = 742
S6_to_B1 = 394
S8_to_B1 = 254
B8_to_S8 = 65
S7_to_B8 = 75
S7_to_B1 = 394
B7_to_S7 = 41
S6_to_B7 = 22
B6_to_S6 = 50
B6_to_S7 = 113
S5_to_B6 = 71
B5_to_S5 = 13
S4_to_B5 = 10
S4_to_B6 = 94
B4_to_S4 = (21 * nilaiTF) + 1
S3_to_B4 = 13
B3_to_S3 = 13
S2_to_B3 = 7
B2_to_S2 = 25
B2_to_S4 = 78
S1_to_B2 = 19

var float price_B1 = na
var float price_S1 = na
var float price_B2 = na
var float price_S2 = na
var float price_B3 = na
var float price_S3 = na
var float price_B4 = na
var float price_S4 = na
var float price_B5 = na
var float price_S5 = na
var float price_B6 = na
var float price_S6 = na
var float price_B7 = na
var float price_S7 = na
var float price_B8 = na
var float price_S8 = na

var float pnl_B1 = na
var float pnl_S1 = na
var float pnl_B2 = na
var float pnl_S2 = na
var float pnl_B3 = na
var float pnl_S3 = na
var float pnl_B4 = na
var float pnl_S4 = na
var float pnl_B5 = na
var float pnl_S5 = na
var float pnl_B6 = na
var float pnl_S6 = na
var float pnl_B7 = na
var float pnl_S7 = na
var float pnl_B8 = na
var float pnl_S8 = na

var int row_idx = na
var int kiri = na
var int kanan = na
var float atas = na
var float bawah = na
var table tbl = table.new(position.bottom_right, columns=21, rows=array.size(halving_dates) + 1, border_width=0)
var box floatingBox = na

table.cell(tbl, 0, 0, text="Halving Time",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 1, 0, text="B1S1",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 2, 0, text="S1B2",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 3, 0, text="B2S2",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 4, 0, text="S2B3",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 5, 0, text="B3S3",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 6, 0, text="S3B4",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 7, 0, text="B4S4",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 8, 0, text="B2S4",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 9, 0, text="S4B5",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 10, 0, text="B5S5",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 11, 0, text="S5B6",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 12, 0, text="S4B6",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 13, 0, text="B6S6",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 14, 0, text="S6B7",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 15, 0, text="B7S7",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 16, 0, text="B6S7",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 17, 0, text="B8S7",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 18, 0, text="B8S8",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 19, 0, text="S8B1",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)
table.cell(tbl, 20, 0, text="S7B1",bgcolor = table_header_bg, text_color=table_forecolor, text_size=size.small)


for i = 0 to array.size(halving_dates) - 1
    halving_time = array.get(halving_dates, i)
    row_idx := i + 1

    if time == halving_time
        label.new(bar_index, high, text="⛏️", style=label.style_label_down, color=label_halving_bg)

    if time == halving_time + days_of_pump_halving
        label.new(bar_index, high, text="🟢", style=label.style_label_down, color=label_buy_bg)

    B1 = halving_time + days_of_B1
    if time == B1
        price_B1 := close
        box_color = price_B1 < price_S7 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S7_to_B1
        kanan := bar_index
        atas := math.max(price_S7, price_B1)  
        bawah := math.min(price_S7, price_B1) 

        if price_S1 > price_B1
            pnl_B1 := ((price_S7 - price_B1) / price_S7) * 100 * leverage / (1 + fee)
        else
            pnl_B1 := ((price_S7 - price_B1) / price_S7) * 100 * leverage / (1 + fee)

        if pnl_B1 < -1000
            pnl_B1 := na
        
        box.new(text = str.tostring(pnl_B1, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        // table.cell(tbl, 1, row_idx + 1, text=str.tostring(pnl_B1, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B1 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, low, text="Time" + "\n to" + "\n Buy", style=label.style_label_up, color=label_must_buy_bg, textcolor=default_forecolor, size=size.small)
        
        box_color1 = price_B1 < price_S8 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S8_to_B1
        kanan := bar_index
        atas := math.max(price_S8, price_B1)  
        bawah := math.min(price_S8, price_B1) 

        if price_S1 > price_B1
            pnl_S8 := ((price_S8 - price_B1) / price_S8) * 100 * leverage / (1 + fee)
        else
            pnl_S8 := ((price_S8 - price_B1) / price_S8) * 100 * leverage / (1 + fee)

        if pnl_S8 < -1000
            pnl_S8 := na

        box.new(text = str.tostring(pnl_S8, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color1, 98), border_color=box_color1, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 19, row_idx, text=str.tostring(pnl_S8, "#.##") + "%",bgcolor = table_bg, text_color=pnl_S8 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 

        box_color2 = price_B1 < price_S7 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S7_to_B1
        kanan := bar_index
        atas := math.max(price_S7, price_B1)  
        bawah := math.min(price_S7, price_B1) 

        if price_S1 > price_B1
            pnl_S7 := ((price_S7 - price_B1) / price_S7) * 100 * leverage / (1 + fee)
        else
            pnl_S7 := ((price_S7 - price_B1) / price_S7) * 100 * leverage / (1 + fee)

        if pnl_S7 < -1000
            pnl_S7 := na

        box.new(text = str.tostring(pnl_S7, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color2, 98), border_color=box_color2, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 20, row_idx, text=str.tostring(pnl_S7, "#.##") + "%",bgcolor = table_bg, text_color=pnl_S7 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 

    S1 = halving_time + days_of_S1
    if time == S1
        price_S1 := close
        box_color = price_S1 > price_B1 ? box_profit_bg : box_loss_bg
        kiri := bar_index - B1_to_S1
        kanan := bar_index
        atas := math.max(price_B1, price_S1)  
        bawah := math.min(price_B1, price_S1) 

        if price_S1 < price_B1
            pnl_B1 := ((price_S1 - price_B1) / price_S1) * 100 * leverage / (1 + fee)
        else
            pnl_B1 := ((price_S1 - price_B1) / price_B1) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_B1, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 1, row_idx, text=str.tostring(pnl_B1, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B1 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, high, text="S1" + "\n" + "\n", style=label.style_label_down, color=label_sell_bg, textcolor=default_forecolor, size=size.small)

    B2 = halving_time + days_of_B2
    if time == B2
        price_B2 := close
        box_color = price_S1 > price_B2 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S1_to_B2
        kanan := bar_index
        atas := math.max(price_B2, price_S1)  
        bawah := math.min(price_B2, price_S1) 

        if price_S1 > price_B2
            pnl_S1 := ((price_S1 - price_B2) / price_S1) * 100 * leverage / (1 + fee)
        else
            pnl_S1 := ((price_S1 - price_B2) / price_B2) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_S1, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 2, row_idx, text=str.tostring(pnl_S1, "#.##") + "%",bgcolor = table_bg, text_color=pnl_S1 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, low, text="\n" + "\n" + "B2 🟢", style=label.style_label_up, color=label_buy_bg, textcolor=default_forecolor, size=size.small)

    S2 = halving_time + days_of_S2
    if time == S2
        price_S2 := close
        box_color = price_S2 > price_B2 ? box_profit_bg : box_loss_bg
        kiri := bar_index - B2_to_S2
        kanan := bar_index
        atas := math.max(price_B2, price_S2)  
        bawah := math.min(price_B2, price_S2) 

        if price_S2 < price_B2
            pnl_B2 := ((price_S2 - price_B2) / price_S2) * 100 * leverage / (1 + fee)
        else
            pnl_B2 := ((price_S2 - price_B2) / price_B2) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_B2, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 3, row_idx, text=str.tostring(pnl_B2, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B2 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, high, text="S2" + "\n" + "\n", style=label.style_label_down, color=label_sell_bg, textcolor=default_forecolor, size=size.small)

    B3 = halving_time + days_of_B3
    if time == B3
        price_B3 := close
        box_color = price_S2 > price_B3 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S2_to_B3
        kanan := bar_index
        atas := math.max(price_B3, price_S2)  
        bawah := math.min(price_B3, price_S2) 

        if price_S2 > price_B3
            pnl_S2 := ((price_S2 - price_B3) / price_S2) * 100 * leverage / (1 + fee)
        else
            pnl_S2 := ((price_S2 - price_B3) / price_B3) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_S2, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 4, row_idx, text=str.tostring(pnl_S2, "#.##") + "%",bgcolor = table_bg, text_color=pnl_S2 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, low, text="\n" + "\n" + "B3", style=label.style_label_up, color=label_buy_bg, textcolor=default_forecolor, size=size.small)

    S3 = halving_time + days_of_S3
    if time == S3
        price_S3 := close
        box_color = price_S3 > price_B3 ? box_profit_bg : box_loss_bg
        kiri := bar_index - B3_to_S3
        kanan := bar_index
        atas := math.max(price_B3, price_S3)  
        bawah := math.min(price_B3, price_S3) 

        if price_S3 < price_B3
            pnl_B3 := ((price_S3 - price_B3) / price_S3) * 100 * leverage / (1 + fee)
        else
            pnl_B3 := ((price_S3 - price_B3) / price_B3) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_B3, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 5, row_idx, text=str.tostring(pnl_B3, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B3 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, high, text="S3" + "\n" + "\n", style=label.style_label_down, color=label_sell_bg, textcolor=default_forecolor, size=size.small)

    B4 = halving_time + days_of_B4
    if time == B4
        price_B4 := close[1]
        box_color = price_S3 > price_B4 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S3_to_B4
        kanan := bar_index
        atas := math.max(price_B4, price_S3)  
        bawah := math.min(price_B4, price_S3) 

        if price_S3 > price_B4
            pnl_S3 := ((price_S3 - price_B4) / price_S3) * 100 * leverage / (1 + fee)
        else
            pnl_S3 := ((price_S3 - price_B4) / price_B4) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_S3, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 6, row_idx, text=str.tostring(pnl_S3, "#.##") + "%",bgcolor = table_bg, text_color=pnl_S3 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, low, text="\n" + "\n" + "B4", style=label.style_label_up, color=label_buy_bg, textcolor=default_forecolor, size=size.small)

    // if time > ( halving_time + days_of_B4) and time == ( halving_time + days_of_B4)
    //     price_S4 := close
    //     box_color = price_S4 > price_B4 ? box_profit_bg : box_loss_bg
    //     kiri := bar_index - B4_to_S4
    //     kanan := bar_index
    //     atas := math.max(price_B4, price_S4)  
    //     bawah := math.min(price_B4, price_S4) 

    //     if price_S4 < price_B4
    //         pnl_B4 := ((price_S4 - price_B4) / price_S4) * 100 * leverage / (1 + fee)
    //     else
    //         pnl_B4 := ((price_S4 - price_B4) / price_B4) * 100 * leverage / (1 + fee)

    //     table.cell(tbl, 7, row_idx, text=str.tostring(pnl_B4, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B4 >= 0 ? table_ongoing_forecolor : table_ongoing_forecolor,text_size = size.small) 
    //     box.delete(floatingBox)
    //     floatingBox := box.new(text = str.tostring(pnl_B4, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 90), border_color=box_color, text_color = color.new(table_ongoing_forecolor,0))

    S4 = halving_time + days_of_S4
    if time == S4
        box.delete(floatingBox)
        price_S4 := close[1]
        box_color = price_S4 > price_B4 ? box_profit_bg : box_loss_bg
        kiri := bar_index - B4_to_S4
        kanan := bar_index - 1
        atas := math.max(price_B4, price_S4)  
        bawah := math.min(price_B4, price_S4) 

        if price_S4 < price_B4
            pnl_B4 := ((price_S4 - price_B4) / price_S4) * 100 * leverage / (1 + fee)
        else
            pnl_B4 := ((price_S4 - price_B4) / price_B4) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_B4, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 7, row_idx, text=str.tostring(pnl_B4, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B4 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, high, text="S4 🔴" + "\n" + "\n", style=label.style_label_down, color=label_sell_bg, textcolor=default_forecolor, size=size.small)

        box_color2 = price_S4 > price_B2 ? box_profit_bg : box_loss_bg
        kiri := bar_index - B2_to_S4
        kanan := bar_index
        atas := math.max(price_B2, price_S4)  
        bawah := math.min(price_B2, price_S4) 

        if price_S4 < price_B2
            pnl_B2 := ((price_S4 - price_B2) / price_S4) * 100 * leverage / (1 + fee)
        else
            pnl_B2 := ((price_S4 - price_B2) / price_B2) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_B2, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color2, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 8, row_idx, text=str.tostring(pnl_B2, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B2 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 

    // if time > ( halving_time + days_of_S4) and time < ( halving_time + days_of_B5)
    //     box.delete(floatingBox)
    //     price_S4 := close
    //     box_color = price_S4 > price_B4 ? box_profit_bg : box_loss_bg
    //     kiri := bar_index - B4_to_S4
    //     kanan := bar_index
    //     atas := math.max(price_B4, price_S4)  
    //     bawah := math.min(price_B4, price_S4) 

    //     if price_S4 < price_B4
    //         pnl_B4 := ((price_S4 - price_B4) / price_S4) * 100 * leverage / (1 + fee)
    //     else
    //         pnl_B4 := ((price_S4 - price_B4) / price_B4) * 100 * leverage / (1 + fee)

    //     box.new(text = str.tostring(pnl_B4, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
    //     table.cell(tbl, 7, row_idx, text=str.tostring(pnl_B4, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B4 >= 0 ? table_profit_forecolor : table_profit_forecolor,text_size = size.small) 

    B5 = halving_time + days_of_B5
    if time == B5
        price_B5 := close
        box_color = price_S4 > price_B5 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S4_to_B5
        kanan := bar_index
        atas := math.max(price_B5, price_S4)  
        bawah := math.min(price_B5, price_S4) 

        if price_S4 > price_B5
            pnl_S4 := ((price_S4 - price_B5) / price_S4) * 100 * leverage / (1 + fee)
        else
            pnl_S4 := ((price_S4 - price_B5) / price_B5) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_S4, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 9, row_idx, text=str.tostring(pnl_S4, "#.##") + "%",bgcolor = table_bg, text_color=pnl_S4 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, low, text="\n" + "\n" + "B5", style=label.style_label_up, color=label_buy_bg, textcolor=default_forecolor, size=size.small)

    S5 = halving_time + days_of_S5
    if time == S5
        price_S5 := close
        box_color = price_S5 > price_B5 ? box_profit_bg : box_loss_bg
        kiri := bar_index - B5_to_S5
        kanan := bar_index
        atas := math.max(price_B5, price_S5)  
        bawah := math.min(price_B5, price_S5) 

        if price_S5 < price_B5
            pnl_B5 := ((price_S5 - price_B5) / price_S5) * 100 * leverage / (1 + fee)
        else
            pnl_B5 := ((price_S5 - price_B5) / price_B5) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_B5, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 10, row_idx, text=str.tostring(pnl_B5, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B5 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, high, text="S5" + "\n" + "\n", style=label.style_label_down, color=label_sell_bg, textcolor=default_forecolor, size=size.small)

    B6 = halving_time + days_of_B6
    if time == B6
        price_B6 := close
        box_color = price_S5 > price_B6 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S5_to_B6
        kanan := bar_index
        atas := math.max(price_B6, price_S5)  
        bawah := math.min(price_B6, price_S5) 

        if price_S5 > price_B6
            pnl_S5 := ((price_S5 - price_B6) / price_S5) * 100 * leverage / (1 + fee)
        else
            pnl_S5 := ((price_S5 - price_B6) / price_B6) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_S5, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 11, row_idx, text=str.tostring(pnl_S5, "#.##") + "%",bgcolor = table_bg, text_color=pnl_S5 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, low, text="\n" + "\n" + "B6 🟢", style=label.style_label_up, color=label_buy_bg, textcolor=default_forecolor, size=size.small)

        box_color2 = price_S4 > price_B6 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S4_to_B6
        kanan := bar_index
        atas := math.max(price_B6, price_S4)  
        bawah := math.min(price_B6, price_S4) 

        if price_S4 > price_B6
            pnl_S4 := ((price_S4 - price_B6) / price_S4) * 100 * leverage / (1 + fee)
        else
            pnl_S4 := ((price_S4 - price_B6) / price_B6) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_S4, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color2, 98), border_color=box_color2, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 12, row_idx, text=str.tostring(pnl_S4, "#.##") + "%",bgcolor = table_bg, text_color=pnl_S4 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
    
    S6 = halving_time + days_of_S6
    if time == S6
        price_S6 := close
        box_color = price_S6 > price_B6 ? box_profit_bg : box_loss_bg
        kiri := bar_index - B6_to_S6
        kanan := bar_index
        atas := math.max(price_B6, price_S6)  
        bawah := math.min(price_B6, price_S6) 

        if price_S6 < price_B6
            pnl_B6 := ((price_S6 - price_B6) / price_S6) * 100 * leverage / (1 + fee)
        else
            pnl_B6 := ((price_S6 - price_B6) / price_B6) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_B6, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 13, row_idx, text=str.tostring(pnl_B6, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B6 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, high, text="S6" + "\n" + "\n", style=label.style_label_down, color=label_sell_bg, textcolor=default_forecolor, size=size.small)

    B7 = halving_time + days_of_B7
    if time == B7
        price_B7 := close
        box_color = price_S6 > price_B7 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S6_to_B7
        kanan := bar_index
        atas := math.max(price_B7, price_S6)  
        bawah := math.min(price_B7, price_S6) 

        if price_S6 > price_B7
            pnl_S6 := ((price_S6 - price_B7) / price_S6) * 100 * leverage / (1 + fee)
        else
            pnl_S6 := ((price_S6 - price_B7) / price_B7) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_S6, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 14, row_idx, text=str.tostring(pnl_S6, "#.##") + "%",bgcolor = table_bg, text_color=pnl_S6 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, low, text="\n" + "\n" + "B7", style=label.style_label_up, color=label_buy_bg, textcolor=default_forecolor, size=size.small)

    S7 = halving_time + days_of_S7
    if time == S7
        price_S7 := close
        box_color = price_S7 > price_B7 ? box_profit_bg : box_loss_bg
        kiri := bar_index - B7_to_S7
        kanan := bar_index
        atas := math.max(price_B7, price_S7)  
        bawah := math.min(price_B7, price_S7) 

        if price_S7 < price_B7
            pnl_B7 := ((price_S7 - price_B7) / price_S7) * 100 * leverage / (1 + fee)
        else
            pnl_B7 := ((price_S7 - price_B7) / price_B7) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_B7, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 15, row_idx, text=str.tostring(pnl_B7, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B7 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, high, text="S7 🔴" + "\n" + "\n", style=label.style_label_down, color=label_sell_bg, textcolor=default_forecolor, size=size.small)

        box_color1 = price_S7 > price_B6 ? box_profit_bg : box_loss_bg
        kiri := bar_index - B6_to_S7
        kanan := bar_index
        atas := math.max(price_B6, price_S7)  
        bawah := math.min(price_B6, price_S7) 

        if price_S7 < price_B6
            pnl_B6 := ((price_S7 - price_B6) / price_S7) * 100 * leverage / (1 + fee)
        else
            pnl_B6 := ((price_S7 - price_B6) / price_B6) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_B6, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color1, 98), border_color=box_color1, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 16, row_idx, text=str.tostring(pnl_B6, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B6 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 

    B8 = halving_time + days_of_B8
    if time == B8
        price_B8 := close
        box_color = price_S7 > price_B8 ? box_profit_bg : box_loss_bg
        kiri := bar_index - S7_to_B8
        kanan := bar_index
        atas := math.max(price_B8, price_S7)  
        bawah := math.min(price_B8, price_S7) 

        if price_S7 > price_B8
            pnl_S7 := ((price_S7 - price_B8) / price_S7) * 100 * leverage / (1 + fee)
        else
            pnl_S7 := ((price_S7 - price_B8) / price_B8) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_S7, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 17, row_idx, text=str.tostring(pnl_S7, "#.##") + "%",bgcolor = table_bg, text_color=pnl_S7 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, low, text="\n" + "\n" + "B8", style=label.style_label_up, color=label_buy_bg, textcolor=default_forecolor, size=size.small)

    S8 = halving_time + days_of_S8
    if time == S8
        price_S8 := close
        box_color = price_S8 > price_B8 ? box_profit_bg : box_loss_bg
        kiri := bar_index - B8_to_S8
        kanan := bar_index
        atas := math.max(price_B8, price_S8)  
        bawah := math.min(price_B8, price_S8) 

        if price_S8 < price_B8
            pnl_B8 := ((price_S8 - price_B8) / price_S8) * 100 * leverage / (1 + fee)
        else
            pnl_B8 := ((price_S8 - price_B8) / price_B8) * 100 * leverage / (1 + fee)

        box.new(text = str.tostring(pnl_B8, "#.##")+ "%", left=kiri, right=kanan, top=atas, bottom=bawah,bgcolor=color.new(box_color, 98), border_color=box_color, text_color = color.new(default_forecolor,90))
        table.cell(tbl, 18, row_idx, text=str.tostring(pnl_B8, "#.##") + "%",bgcolor = table_bg, text_color=pnl_B8 >= 0 ? table_profit_forecolor : table_loss_forecolor,text_size = size.small) 
        label.new(bar_index, high, text="S8" + "\n" + "\n", style=label.style_label_down, color=label_sell_bg, textcolor=default_forecolor, size=size.small)

    table.cell(tbl, 0, row_idx, text=str.format("{0,date,yyyy-MM-dd}", halving_time),bgcolor = table_bg, text_color=table_forecolor,text_size = size.small)
