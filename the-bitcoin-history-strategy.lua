//@version=6
strategy('The Bitcoin History Indicator', overlay = true, default_qty_value = 100, default_qty_type = strategy.percent_of_equity)

color_label_halving = input.color(color.rgb(255, 255, 100, 70), 'Label Halving')
color_text_halving = input.color(color.rgb(255, 255, 255, 0), 'Text Halving')

halving_dates = array.new_int()
array.push(halving_dates, timestamp('2009-01-03 00:00'))
array.push(halving_dates, timestamp('2012-11-28 00:00'))
array.push(halving_dates, timestamp('2016-07-09 00:00'))
array.push(halving_dates, timestamp('2020-05-11 00:00'))
array.push(halving_dates, timestamp('2024-04-20 00:00'))
days_of_B1 = 940 * 86400 * 1000
days_of_S1 = 241 * 86400 * 1000
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

for i = 0 to array.size(halving_dates) - 1 by 1
    halving_time = array.get(halving_dates, i)

    if time == halving_time
        label.new(bar_index, high, text = '⛏️' + str.tostring(i), style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)

    if time == halving_time + days_of_B1
        label.new(bar_index, high, text = 'Buy Here' + str.tostring(i), style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Short")
        strategy.entry("Long", strategy.long, qty = 1)

    if time == halving_time + days_of_S1
        label.new(bar_index, high, text = 'S1', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Long")
        strategy.entry("Short", strategy.short, qty = 1)

    if time == halving_time + days_of_B2
        label.new(bar_index, high, text = 'B2', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Short")
        strategy.entry("Long", strategy.long, qty = 1)

    if time == halving_time + days_of_S2
        label.new(bar_index, high, text = 'S2', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Long")
        strategy.entry("Short", strategy.short, qty = 1)

    if time == halving_time + days_of_B3
        label.new(bar_index, high, text = 'B3', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Short")
        strategy.entry("Long", strategy.long, qty = 1)

    if time == halving_time + days_of_S3
        label.new(bar_index, high, text = 'S3', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Long")
        strategy.entry("Short", strategy.short, qty = 1)

    if time == halving_time + days_of_B4
        label.new(bar_index, high, text = 'B4', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Short")
        strategy.entry("Long", strategy.long, qty = 1)

    if time == halving_time + days_of_S4
        label.new(bar_index, high, text = 'S4', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Long")
        strategy.entry("Short", strategy.short, qty = 1)

    if time == halving_time + days_of_B5
        label.new(bar_index, high, text = 'B5', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Short")
        strategy.entry("Long", strategy.long, qty = 1)

    if time == halving_time + days_of_S5
        label.new(bar_index, high, text = 'S5', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Long")
        strategy.entry("Short", strategy.short, qty = 1)

    if time == halving_time + days_of_B6
        label.new(bar_index, high, text = 'B6', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Short")
        strategy.entry("Long", strategy.long, qty = 1)

    if time == halving_time + days_of_S6
        label.new(bar_index, high, text = 'S6', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Long")
        strategy.entry("Short", strategy.short, qty = 1)

    if time == halving_time + days_of_B7
        label.new(bar_index, high, text = 'B7', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Short")
        strategy.entry("Long", strategy.long, qty = 1)

    if time == halving_time + days_of_S7
        label.new(bar_index, high, text = 'S7', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Long")
        strategy.entry("Short", strategy.short, qty = 1)

    if time == halving_time + days_of_B8
        label.new(bar_index, high, text = 'B8', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Short")
        strategy.entry("Long", strategy.long, qty = 1)

    if time == halving_time + days_of_S8
        label.new(bar_index, high, text = 'S8', style = label.style_label_down, color = color_label_halving, textcolor = color_text_halving)
        strategy.close("Long")
        strategy.entry("Short", strategy.short, qty = 1)
