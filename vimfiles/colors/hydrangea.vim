" Vim color file -- hydrangea
" Maintainer:   kamichidu <c.kamunagi@gmail.com>
" Last Change:  26-Jul-2018.

set background=dark
hi clear
" syn reset
let g:colors_name="hydrangea"

let save_cpo = &cpo
set cpo&vim

" NR-16   NR-8    COLOR NAME ~
" 0       0       Black
" 1       4       DarkBlue
" 2       2       DarkGreen
" 3       6       DarkCyan
" 4       1       DarkRed
" 5       5       DarkMagenta
" 6       3       Brown, DarkYellow
" 7       7       LightGray, LightGrey, Gray, Grey
" 8       0*      DarkGray, DarkGrey
" 9       4*      Blue, LightBlue
" 10      2*      Green, LightGreen
" 11      6*      Cyan, LightCyan
" 12      1*      Red, LightRed
" 13      5*      Magenta, LightMagenta
" 14      3*      Yellow, LightYellow
" 15      7*      White
let s:nr16_black = 0
let s:nr16_darkblue = 1
let s:nr16_darkgreen = 2
let s:nr16_darkcyan = 3
let s:nr16_darkred = 4
let s:nr16_darkmagenta = 5
let s:nr16_darkyellow = 6
let s:nr16_gray = 7
let s:nr16_darkgray = 8
let s:nr16_blue = 9
let s:nr16_green = 10
let s:nr16_cyan = 11
let s:nr16_red = 12
let s:nr16_magenta = 13
let s:nr16_yellow = 14
let s:nr16_white = 15

" colors from https://irocore.com/read-list/
" 藍色
let s:aiiro = ['#105779', s:nr16_darkblue]
" 藍色鳩羽
let s:aiirohatoba = '#756d91'
" 藍媚茶
let s:aikobicha = '#555647'
" 藍墨茶
let s:aisumicha = '#373c38'
" 相済茶
let s:aisumicha = ['#373c38', s:nr16_gray]
" 藍鉄色
let s:aitetsuiro = '#003a47'
" 藍鼠
let s:ainezu = '#6b818e'
" 藍海松茶
let s:aimirucha = '#56564b'
" 青
let s:ao = '#0095d9'
" 葵色
let s:aoiiro = '#aa89bd'
" 青朽葉
let s:aokuchiba = '#ada250'
" 青白橡
let s:aoshirotsurubami = '#85916d'
" 青竹色
let s:aotakeiro = '#7ebeab'
" 青丹
let s:aoni = '#858954'
" 青鈍
let s:aonibi = '#324356'
" 青藤
let s:aofuji = '#8aa2d3'
" 青緑
let s:aomidori = '#00a497'
" 青紫
let s:aomurasaki = '#6846a5'
" 赤
let s:aka = '#f20000'
" 赤支子
let s:akaikuchinashi = '#f2934e'
" 赤朽葉
let s:akakuchiba = '#db8449'
" 赤香色
let s:akakoiro = '#f6b894'
" 赤白橡
let s:akashirotsurubami = '#fed2ae'
" 赤橙
let s:akadaidai = '#ea5506'
" 茜色
let s:akaneiro = '#b7282e'
" 赤紅
let s:akabeni = '#d81f35'
" 赤紫
let s:akamurasaki = ['#eb6ea5', s:nr16_darkmagenta]
" 灰汁色
let s:akuiro = '#bcb09c'
" 緋
let s:ake = '#ba2636'
" 曙色
let s:akebonoiro = '#f9a383'
" 浅緋
let s:asaake = '#df7163'
" 浅葱色
let s:asagiiro = '#00a5bf'
" 浅葱鼠
let s:asaginezu = '#94a8b0'
" 浅縹
let s:asahanada = '#84b9cb'
" 浅緑
let s:asamidori = '#9bcf97'
" 浅紫
let s:asamurasaki = '#c4a3bf'
" 小豆色
let s:azukiiro = '#a04940'
" 小豆鼠
let s:azukinezu = '#715454'
" 天色
let s:amairo = '#0086cc'
" 亜麻色
let s:amairo = '#c7b897'
" 飴色
let s:ameiro = '#cd6118'
" 菖蒲色
let s:ayameiro = ['#b168a8', s:nr16_darkcyan]
" 洗柿
let s:araigaki = '#f0b694'
" 洗朱
let s:araishu = '#d0826c'
" 退紅
let s:arazome = '#ffb3a7'
" 淡藤色
let s:awafujiiro = '#d2d0e8'
" 杏色
let s:anzuiro = ['#f4a466', s:nr16_darkyellow]
" 威光茶
let s:ikoucha = '#a8a256'
" 苺色
let s:ichigoiro = '#bb5561'
" 一斤染
let s:ikkonzome = '#fcd4d5'
" 今紫
let s:imamurasaki = '#563779'
" 今様色
let s:imayouiro = '#d0576b'
" 岩井茶
let s:iwaicha = '#6f6f43'
" 不言色
let s:iwanuiro = '#ffd768'
" 鶯色
let s:uguisuiro = '#838b0d'
" 鶯茶
let s:uguisucha = '#715c1f'
" 鬱金色
let s:ukoniro = '#f7c229'
" 薄青
let s:usuao = '#a0cea8'
" 薄浅葱
let s:usuasagi = '#a2d7dd'
" 薄色
let s:usuiro = '#ceb4b9'
" 薄柿
let s:usugaki = ['#d4acad', s:nr16_magenta]
" 浅黄
let s:usuki = '#edd3a1'
" 淡黄蘗
let s:usukihada = '#f9f1c0'
" 薄紅
let s:usukurenai = '#b15c65'
" 淡香
let s:usuko = '#f3bf88'
" 薄桜
let s:usuzakura = '#fcf5f7'
" 薄墨色
let s:usuzumiiro = ['#a3a3a2', s:nr16_gray]
" 薄花色
let s:usuhanairo = '#82a9da'
" 薄藤色
let s:usufujiiro = '#c7c3e1'
" 淡紅藤
let s:usubenifuji = '#e9c3dc'
" 薄水色
let s:usumizuiro = '#bce1df'
" 薄緑
let s:usumidori = '#cae5cd'
" 薄柳
let s:usuyanagi = '#e0e7aa'
" 空五倍子色
let s:utsubushiiro = '#9d896c'
" 卯の花色
let s:unohanairo = '#fbfbf6'
" 梅重
let s:umegasane = '#e9546b'
" 梅染
let s:umezome = '#b48a76'
" 梅鼠
let s:umenezumi = '#ad7984'
" 梅紫
let s:umemurasaki = '#493759'
" 裏葉柳
let s:urahayanagi = '#c1d8ac'
" 裏葉色
let s:urahairo = '#a4c2a9'
" 裏柳
let s:urayanagi = ['#c1d8ac', s:nr16_white]
" 江戸茶
let s:edocha = '#cd8c5c'
" 江戸紫
let s:edomurasaki = '#745399'
" 葡萄色
let s:ebiiro = '#6e1e51'
" 海老色
let s:ebiiro = '#932e40'
" 葡萄染
let s:ebizome = '#7a4171'
" 葡萄茶
let s:ebicha = '#640125'
" 海老茶
let s:ebicha = '#6c2c2f'
" 遠州茶
let s:enshucha = '#ca8269'
" 臙脂色
let s:enjiiro = '#9b003f'
" 臙脂鼠
let s:enjinezu = '#85646c'
" 鉛丹色
let s:entaniro = '#ec6d51'
" 老竹色
let s:oitakeiro = '#769164'
" 老緑
let s:oimidori = '#405c36'
" 楝色
let s:ouchiiro = ['#a596c7', s:nr16_magenta]
" 黄土色
let s:odoiro = '#ce9b0e'
" 黄丹
let s:oni = '#ee7948'
" 鸚緑
let s:ouryoku = '#9fbb00'
" 乙女色
let s:otomeiro = '#f9d0c5'
" 御納戸色
let s:onandoiro = '#007083'
" 御納戸茶
let s:onandocha = '#465d4c'
" 女郎花
let s:ominaeshi = '#f2f2b0'
" 御召御納戸
let s:omeshionando = '#4c6473'
" 御召茶
let s:omeshicha = '#43676b'
" 織部
let s:oribe = ['#125115', s:nr16_darkgreen]
" 柿色
let s:kakiiro = '#de6a1c'
" 柿渋色
let s:kakishibuiro = '#bd7862'
" 杜若
let s:kakitsubata = '#5e3862'
" 褐色
let s:kachiiro = '#003847'
" 勝色
let s:katsuiro = ['#181b39', s:nr16_darkblue]
" 樺色
let s:kabairo = '#c5591a'
" 樺茶
let s:kabacha = '#726250'
" 甕覗
let s:kamenozoki = '#c5e4ed'
" 鴨の羽色
let s:kamonohairo = '#00695b'
" 茅色
let s:kayairo = '#c7b183'
" 唐紅
let s:karakurenai = '#ea0032'
" 韓紅
let s:karakurenai = '#ea0032'
" 乾鮭色
let s:karasakeiro = '#eb9793'
" 芥子色
let s:karashiiro = '#d0af4c'
" 唐茶
let s:karacha = '#a06705'
" 刈安
let s:kariyasu = '#ffed00'
" 土器色
let s:kawarakeiro = '#c37854'
" 萱草色
let s:kanzoiro = '#fda900'
" 黄浅緑
let s:kiasamidori = '#8cb155'
" 黄色
let s:kiiro = '#ffd900'
" 黄唐茶
let s:kigaracha = '#b98c46'
" 黄枯茶
let s:kigaracha = '#765c47'
" 桔梗色
let s:kikyoiro = '#624498'
" 麹塵
let s:kikujin = '#6e7955'
" 黄支子
let s:kikuchinashi = '#ffdb4f'
" 黄朽葉
let s:kikuchiba = '#d3a243'
" 紀州茶
let s:kishucha = '#856859'
" 狐色
let s:kitsuneiro = '#d9972f'
" 黄橡
let s:kitsurubami = ['#a27033', s:nr16_darkyellow]
" 生成色
let s:kinariiro = ['#f7efe3', s:nr16_white]
" 黄蘗
let s:kihada = '#fef263'
" 黄海松茶
let s:kimirucha = '#918754'
" 伽羅色
let s:kyarairo = '#d8a373'
" 京藤
let s:kyoufuji = '#c08fb3'
" 京紫
let s:kyomurasaki = '#772f6d'
" 金茶
let s:kincha = '#ce7a19'
" 銀色
let s:giniro = '#c0c0c0'
" 銀朱
let s:ginshu = '#f12b00'
" 銀煤竹
let s:ginsusutake = '#82663a'
" 銀鼠
let s:ginnezumi = '#bbbcbf'
" 草色
let s:kusairo = '#7b8d42'
" 孔雀青
let s:kujakuao = ['#0086a2', s:nr16_cyan]
" 孔雀緑
let s:kujakumidori = '#008e74'
" 梔子色
let s:kuchinashiiro = ['#ffd768', s:nr16_yellow]
" 支子色
let s:kuchinashiiro = ['#ffd768', s:nr16_yellow]
" 朽葉色
let s:kuchibairo = '#917347'
" 涅色
let s:kuriiro = ['#433634', s:nr16_darkgray]
" 栗色
let s:kuriiro = ['#762f07', s:nr16_darkmagenta]
" 栗梅
let s:kiriume = ['#6c1912', s:nr16_darkmagenta]
" 栗皮色
let s:kurikawairo = '#6a4028'
" 栗皮茶
let s:kurikawacha = '#824522'
" 胡桃色
let s:kurumiiro = '#a86f4c'
" 胡桃染
let s:kurumizome = '#a58f86'
" 紅の八塩
let s:kurenainoyashio = '#ad002d'
" 黒緋
let s:kuroake = '#86473f'
" 鉄色
let s:kuroganeiro = '#102e24'
" 黒橡
let s:kurotsurubami = '#322c28'
" 黒鳶
let s:kurotobi = ['#432f2f', s:nr16_darkgray]
" 黒紅
let s:kurobeni = '#302833'
" 黒紅梅
let s:kurobeniume = '#302833'
" 桑色
let s:kuwairo = '#dabc91'
" 桑染
let s:kuwazome = '#dabc91'
" 桑の実色
let s:kuwanomiiro = '#550030'
" 群青色
let s:gunjouiro = '#005baa'
" 消炭色
let s:keshizumiiro = '#595045'
" 憲法染
let s:kenpozome = '#574738'
" 月白
let s:geppaku = '#f6f7f8'
" 玄
let s:gen = ['#3e1e00', s:nr16_darkmagenta]
" 濃藍
let s:koiai = '#002e4e'
" 香色
let s:kouiro = '#efcd9a'
" 光悦茶
let s:kouetsucha = '#9a725c'
" 柑子色
let s:koujiiro = '#ff5234'
" 香染
let s:kouzome = '#ad7d4c'
" 紅梅色
let s:kobaiiro = '#e86b79'
" 高麗納戸
let s:kourainando = '#104539'
" 黄櫨染
let s:korozen = '#d74b22'
" 深緋
let s:kokiake = '#c20024'
" 深支子
let s:kokikuchinashi = '#efbb2c'
" 深縹
let s:kokihanada = '#2a4073'
" 深紫
let s:kokimurasaki = '#493759'
" 苔色
let s:kokeiro = '#78882d'
" 焦茶
let s:kogecha = '#6a4d32'
" 古代紫
let s:kodaimurasaki = '#8c6589'
" 琥珀色
let s:kohakuiro = '#ea930a'
" 媚茶
let s:kobicha = '#716246'
" 昆布茶
let s:kobucha = '#6f6045'
" 小町鼠
let s:komachinezu = '#e5e2e4'
" 小麦色
let s:komugiiro = '#e4a343'
" 小紫
let s:komurasaki = '#4b0d43'
" 紺
let s:kon = '#001a43'
" 紺桔梗
let s:konkikyou = '#211e55'
" 紺青色
let s:konjouiro = '#005499'
" 紺鼠
let s:konnezu = ['#3f4551', s:nr16_darkgray]
" 金春色
let s:konparuiro = '#5ac2d9'
" 紺藤
let s:konfuji = '#6592c6'
" 紺碧
let s:konpeki = '#005b98'
" 胡粉色
let s:gofuniro = '#fffffc'
" 左伊多津万色
let s:saitadumairo = '#327131'
" 嵯峨鼠
let s:saganezu = '#b08d84'
" 桜色
let s:sakurairo = '#feeeed'
" 桜鼠
let s:sakuranezumi = '#d8c6bc'
" 錆浅葱
let s:sabiasagi = '#5c9291'
" 錆御納戸
let s:sabionando = '#406f79'
" 錆鉄御納戸
let s:sabitetsuonando = '#485859'
" 錆納戸
let s:sabinando = '#406f79'
" 錆利休
let s:sabirikyu = '#877254'
" 珊瑚色
let s:sangoiro = '#ef8468'
" 珊瑚珠色
let s:shuiro = '#ef454a'
" 柘榴色
let s:zakuroiro = '#c92e36'
" 紫苑色
let s:shioniro = '#968abd'
" 芝翫茶
let s:shikancha = '#bf795d'
" 紫紺
let s:shikon = '#400b36'
" 至極色
let s:shigokuiro = '#2d0425'
" 宍色
let s:shishiiro = '#efab93'
" 紫檀色
let s:shitaniro = ['#6a1435', s:nr16_darkmagenta]
" 漆黒
let s:sikkoku = '#080000'
" 東雲色
let s:shinonomeiro = '#f19072'
" 赤銅色
let s:shakudoiro = '#7e0f09'
" 洒落柿
let s:sharegaki = '#f7bd8f'
" 朱殷
let s:shuan = '#740a00'
" 朱色
let s:shuiro = ['#ef454a', s:nr16_red]
" 猩々緋
let s:shojohi = '#e7001d'
" 白藍
let s:shiraai = '#d4ecee'
" 白茶
let s:shiracha = '#dac4a5'
" 白百合色
let s:shirayuriiro = '#fdfcf5'
" 白
let s:shiro = '#fffffd'
" 白菫色
let s:shirosumireiro = '#e9eaf5'
" 白橡
let s:shirotsurubami = '#cbb994'
" 白鼠
let s:shironezumi = ['#e6e6e6', s:nr16_gray]
" 白練
let s:shironeri = '#fcfaf2'
" 白縹
let s:shirohanada = '#dff2fc'
" 深紅
let s:shinku = '#ad002d'
" 真紅
let s:shinku = '#ad002d'
" 真朱
let s:shinshu = ['#d72500', s:nr16_red]
" 新橋色
let s:shinbashiiro = '#5ac2d9'
" 深碧
let s:shinpeki = '#005e15'
" 純白
let s:junpaku = '#ffffff'
" 甚三紅
let s:jinzamomi = '#d23f40'
" 蘇芳
let s:suo = '#7e2639'
" 蘇芳香
let s:suoko = '#b23e52'
" 煤竹色
let s:susutakeiro = '#70564a'
" 錫色
let s:suzuiro = '#9ea1a3'
" 雀色
let s:suzumeiro = '#864337'
" 雀茶
let s:suzumecha = '#954039'
" 素鼠
let s:sunezumi = '#737373'
" 墨色
let s:sumiiro = ['#000a02', s:nr16_black]
" 菫色
let s:sumireiro = '#7065a3'
" 青漆
let s:seishitsu = '#184212'
" 青磁色
let s:seijiiro = '#7ebea5'
" 青白磁
let s:seihakuji = '#ebf4f4'
" 青碧
let s:seiheki = '#478384'
" 青藍
let s:seiran = '#00558f'
" 赤褐色
let s:sekkashoku = '#683f36'
" 仙斎茶
let s:sensaicha = '#474b42'
" 千歳茶
let s:senzaicha = ['#48493f', s:nr16_darkgray]
" 千歳緑
let s:chitosemidori = '#335719'
" 煎茶色
let s:senchairo = '#8c6450'
" 鮮緑
let s:senryoku = '#6cbb5a'
" 蒼色
let s:soushoku = '#007655'
" 宗伝唐茶
let s:sodenkaracha = '#a16d5d'
" 承和色
let s:sogairo = ['#f3f47f', s:nr16_yellow]
" 蘇比
let s:sohi = '#fba027'
" 纁
let s:sohi = '#e0815e'
" 赭
let s:soho = '#ca4829'
" 空色
let s:sorairo = '#73b8e2'
" 空色鼠
let s:soraironezu = '#b8c8d1'
" 代赭色
let s:taishairo = '#b36c3c'
" 玉子色
let s:tamagoiro = '#ffdf85'
" 淡黄
let s:tankou = '#f8e58c'
" 淡紅色
let s:tankoushoku = '#fadce9'
" 胆礬色
let s:tanbairo = '#007d7a'
" 蒲公英色
let s:tanpopoiro = '#ffe200'
" 橙色
let s:daidaiiro = ['#ee7800', s:nr16_yellow]
" 団十郎茶
let s:danjurocha = '#9f563a'
" 千草色
let s:chigusairo = ['#3a8fb7', s:nr16_darkcyan]
" 茶色
let s:chairo = '#965042'
" 茶褐色
let s:chakasshoku = '#664032'
" 長春色
let s:choshuniro = '#d88b83'
" 丁子色
let s:chojiiro = '#efcd9a'
" 丁子染
let s:chojizome = '#ddb87e'
" 丁子茶
let s:chojicha = '#b4866b'
" 鴨頭草
let s:tsukikusa = '#68a5da'
" 躑躅色
let s:tutujiiro = '#e02c87'
" 露草色
let s:tsuyukusairo = '#71a4d9'
" 鉄御納戸
let s:tetsuonando = '#455765'
" 鉄紺
let s:tetsukon = ['#003149', s:nr16_darkblue]
" 照柿
let s:terigaki = '#f89264'
" 藤黄
let s:too = '#f7c114'
" 玉蜀黍色
let s:toumorokoshiiro = '#eec362'
" 鴇浅葱
let s:tokiasagi = '#b88884'
" 朱鷺色
let s:tokiiro = '#f3a696'
" 鴇色
let s:tokiiro = '#f3a696'
" ときがら茶
let s:tokigaracha = '#e09e87'
" 鴇羽色
let s:tokihairo = '#f49e95'
" 常盤色
let s:tokiwairo = '#007b43'
" 木賊色
let s:tokusairo = '#22825d'
" 砥粉色
let s:tonokoiro = ['#f4dda5', s:nr16_white]
" 殿茶
let s:tonocha = '#84a1a8'
" 沈香茶
let s:tonocha = '#84a1a8'
" 礪茶
let s:tonocha = ['#9f6f55', s:nr16_darkred]
" 鳶色
let s:tobiiro = '#7a380f'
" 鳥の子色
let s:torinokoiro = '#f8eed1'
" 丼鼠
let s:dobunezumi = ['#595455', s:nr16_darkgray]
" 苗色
let s:naeiro = '#b0ca71'
" 中紅花
let s:nakakurenai = '#ee869a'
" 中紅
let s:nakabeni = '#eb6159'
" 茄子紺
let s:nasukon = '#824880'
" 菜種油色
let s:nataneaburairo = ['#dec031', s:nr16_yellow]
" 撫子色
let s:nadeshikoiro = '#eebbcb'
" 菜の花色
let s:nanohanairo = '#fcd900'
" 生壁色
let s:namakabeiro = '#aa8c63'
" 鉛色
let s:namariiro = '#7b7c7d'
" 納戸色
let s:nandoiro = '#008899'
" 丹色
let s:niiro = '#e45e32'
" 似紫
let s:nisemurasaki = '#513743'
" 鈍色
let s:nibiiro = '#727171'
" 濡羽色
let s:nurebairo = ['#000b00', s:nr16_black]
" 根岸色
let s:negishiiro = '#908e65'
" 鼠色
let s:nezumiiro = '#7d7d7d'
" 熨斗目色
let s:noshimeiro = '#175b66'
" 熨斗目花色
let s:noshimehanairo = '#426579'
" 灰色
let s:haiiro = '#9f9d9a'
" 灰桜
let s:haizakura = '#e8d3d1'
" 灰茶
let s:haicha = '#98623c'
" 白銅色
let s:hakudouiro = '#d3dbe2'
" 半色
let s:hashitairo = '#a69abd'
" 櫨染
let s:hajizome = '#d9a62e'
" 鳩羽色
let s:hatobairo = '#95859c'
" 鳩羽鼠
let s:hatobanezumi = ['#9e8b8e', s:nr16_gray]
" 花浅葱
let s:hanaasagi = '#1e88a8'
" 花色
let s:hanairo = '#0086ad'
" 花紺青
let s:hanakonjou = '#062c54'
" 縹色
let s:hanadairo = '#0086ad'
" 花葉色
let s:hanabairo = '#fbd26b'
" 花萌葱
let s:hanamoegi = '#008d56'
" 花緑青
let s:hanarokusho = '#5ab5b2'
" 朱華
let s:hanezu = '#f4a57a'
" 榛摺
let s:harizuri = '#79520b'
" 梅幸茶
let s:baikoucha = '#aaa751'
" 薔薇色
let s:barairo = '#e73275'
" 肥後煤竹
let s:higosusutake = ['#897858', s:nr16_gray]
" 秘色
let s:hisoku = '#abced8'
" 檜皮色
let s:hihadairo = '#7b4334'
" 鶸色
let s:hiwairo = '#d6d000'
" 鶸茶
let s:hiwacha = '#8c8861'
" 鶸萌黄
let s:hiwamoegi = '#82ae46'
" 白群
let s:byakugun = '#83ccd2'
" 白緑
let s:byakuroku = '#daead0'
" 天鵞絨
let s:veludo = '#00451e'
" 枇杷茶
let s:biwacha = '#ae7c4f'
" 檳榔子黒
let s:binroujiguro = '#00081a'
" 檳榔子染
let s:binroujizome = ['#433d3c', s:nr16_darkgray]
" 深藍
let s:fukaai = '#004150'
" 深川鼠
let s:fukagawanezumi = '#85a1a0'
" 深藍色
let s:fukakiaiiro = '#006a66'
" 深緑
let s:fukamidori = ['#004025', s:nr16_darkgreen]
" 柴色
let s:fushiiro = '#998c78'
" 柴染
let s:fushizome = '#b28c6e'
" 藤色
let s:fujiiro = '#baa7cc'
" 藤煤竹
let s:fujisusutake = ['#5a5359', s:nr16_darkgray]
" 藤納戸
let s:fujinando = '#606da1'
" 藤鼠
let s:fujinezumi = '#6e75a4'
" 藤紫
let s:fujimurasaki = '#8f82bc'
" 二藍
let s:futaai = '#888abc'
" 二人静
let s:futarishizuka = '#583b55'
" 葡萄鼠
let s:budounezumi = '#705b67'
" 碧色
let s:hekishoku = '#007f89'
" 紅赤
let s:beniaka = '#e5004f'
" 紅色
let s:beniiro = '#c41a41'
" 紅鬱金
let s:beniukon = '#cb8347'
" 紅掛空色
let s:benikakesorairo = '#8491c3'
" 紅掛花色
let s:benikakehanairo = '#68699b'
" 紅樺
let s:benikaba = '#b63d1b'
" 紅桔梗
let s:benikikyou = '#9c308d'
" 紅消鼠
let s:benikeshinezumi = '#524748'
" 紅柑子
let s:benikouji = '#cc5229'
" 紅唐
let s:benitou = '#d23f40'
" 紅鳶
let s:benitobi = '#9a493f'
" 紅鼠
let s:beninezu = '#a06f70'
" 紅緋
let s:benihi = ['#f83929', s:nr16_red]
" 紅檜皮
let s:benihihada = '#7b4741'
" 紅鶸色
let s:benihiwairo = '#c9396d'
" 紅藤
let s:benifuji = '#cca6bf'
" 紅碧
let s:benimidori = ['#8491c3', s:nr16_blue]
" 紅柄色
let s:bengarairo = '#aa562e'
" 弁柄色
let s:bengarairo = '#8f2e14'
" 牡丹色
let s:botan = '#e761a4'
" 舛花色
let s:masuhanairo = '#5b7e91'
" 松葉色
let s:sensaicha = '#3f7735'
" 蜜柑色
let s:mikaniro = '#f08300'
" 水浅葱
let s:mizuasagi = '#8cd2bc'
" 水色
let s:mizuiro = '#7fcce3'
" 水柿
let s:mizugaki = '#b56c60'
" み空色
let s:misorairo = ['#6c9bd2', s:nr16_cyan]
" 緑
let s:midori = '#3eb370'
" 湊鼠
let s:minatonezumi = '#77969a'
" 水縹
let s:mihanada = '#7ec7d8'
" 海松色
let s:miruiro = '#596327'
" 海松茶
let s:mirucha = '#57543d'
" 麦藁色
let s:mugiwarairo = '#e3c576'
" 虫襖
let s:mushiao = '#20604f'
" 蒸栗色
let s:mushikuriiro = '#efeacc'
" 紫
let s:murasaki = '#884898'
" 紫式部
let s:murasakishikibu = '#90326d'
" 紫鳶
let s:murasakitobi = '#5f414b'
" 滅紫
let s:messhi = '#594255'
" 萌木色
let s:moegiiro = '#a7bd00'
" 萌葱色
let s:moegiiro = '#006d4d'
" 萌黄色
let s:moegiiro = '#86b81b'
" 木蘭
let s:mokuran = ['#c7b370', s:nr16_yellow]
" 桃色
let s:momoiro = '#f58f98'
" 百塩茶
let s:momoshiocha = '#724938'
" 桃花色
let s:momohanairo = '#f9aea5'
" 柳煤竹
let s:yanagisusutake = '#4a593d'
" 柳染
let s:yanagisome = '#93b881'
" 柳茶
let s:yanagicha = '#a3a86c'
" 柳鼠
let s:yanaginezumi = '#c8d5bb'
" 大和柿
let s:yamatogaki = '#efae7c'
" 山鳩色
let s:yamabatoiro = '#767c6b'
" 山吹色
let s:yamabukiiro = ['#f8b400', s:nr16_yellow]
" 山吹茶
let s:yamabukicha = ['#c89932', s:nr16_yellow]
" 楊梅色
let s:yamamomoiro = '#c6a35b'
" 雄黄
let s:yuuou = '#ee9d19'
" 柚葉色
let s:yuzuhairo = '#006543'
" 聴色
let s:yurushiiro = '#fcd4d5'
" 羊羹色
let s:youkaniro = '#6d3c14'
" 洋紅色
let s:youkoushoku = '#da003d'
" 吉岡染
let s:yoshiokazome = '#43341b'
" 駱駝色
let s:rakudairo = '#bf794e'
" 蘭茶
let s:rancha = '#d19826'
" 璃寛茶
let s:rikancha = '#6a5d21'
" 利休白茶
let s:rikyushiracha = '#e6e3c5'
" 利休茶
let s:rikyucha = '#897845'
" 柳緑
let s:ryuuryoku = '#7baa17'
" 竜胆色
let s:rindouiro = '#6967ab'
" 瑠璃色
let s:ruriiro = '#004898'
" 瑠璃紺
let s:rurikon = '#224b8f'
" 檸檬色
let s:remoniro = '#ecdf2b'
" 煉瓦色
let s:rengairo = '#aa5c3f'
" 呂色
let s:roiro = '#0c0c0c'
" 緑青
let s:rokusho = ['#5bad92', s:nr16_green]
" 路考茶
let s:rokocha = '#927a30'
" 若草色
let s:wakakusairo = '#abc900'
" 若竹色
let s:wakatakeiro = '#7cc28e'
" 若菜色
let s:wakanairo = '#ccde68'
" 若苗色
let s:wakanaeiro = '#c7dc68'
" 若葉色
let s:wakabairo = ['#a4ca68', s:nr16_green]
" 若緑
let s:wakamidori = '#a5cd89'
" 若紫
let s:wakamurasaki = '#be84b8'
" 若芽色
let s:wakameiro = '#e8ec98'
" 山葵色
let s:wasabiiro = '#8ec298'
" 勿忘草
let s:wasurenagusa = '#9cc5e6'

" constants
let s:NONE = ['NONE', 'NONE', 'NONE']
let s:underline = ['underline', 'underline', 'underline']
let s:undercurl = ['undercurl', 'underline', 'underline']

function! s:args(fg, bg, deco) abort
    " fg and bg : 0 is gui color, 1 is cterm color
    " deco : 0 is gui, 1 is cterm, 2 is term
    return [
    \   'guifg=' . a:fg[0],
    \   'ctermfg=' . a:fg[1],
    \   'guibg=' . a:bg[0],
    \   'ctermbg=' . a:bg[1],
    \   'gui=' . a:deco[0],
    \   'cterm=' . a:deco[1],
    \   'term=' . a:deco[2],
    \]
endfunction

" :help highlight-groups
let s:highlights = [
\   ['hi', 'Normal'] + s:args(s:kinariiro, s:nurebairo, s:NONE),
\   ['hi', 'NonText'] + s:args(s:aisumicha, s:NONE, s:NONE),
\   ['hi', 'Folded'] + s:args(s:kinariiro, s:nurebairo, s:underline),
\   ['hi', 'LineNr'] + s:args(s:usuzumiiro, s:NONE, s:NONE),
\   ['hi', 'CursorLineNr'] + s:args(s:shironezumi, s:NONE, s:NONE),
\   ['hi', 'Directory'] + s:args(s:benimidori, s:NONE, s:NONE),
\   ['hi', 'SpecialKey'] + s:args(s:kuriiro, s:NONE, s:NONE),
\   ['hi', 'SpellBad'] + s:args(s:NONE, s:NONE, s:undercurl),
\   ['hi', 'SpellCap'] + s:args(s:NONE, s:NONE, s:undercurl),
\   ['hi', 'SpellLocal'] + s:args(s:NONE, s:NONE, s:undercurl),
\   ['hi', 'SpellRare'] + s:args(s:NONE, s:NONE, s:undercurl),
\   ['hi', 'DiffAdd'] + s:args(s:NONE, s:fukamidori, s:NONE),
\   ['hi', 'DiffChange'] + s:args(s:NONE, s:aiiro, s:NONE),
\   ['hi', 'DiffDelete'] + s:args(s:NONE, s:kiriume, s:NONE),
\   ['hi', 'DiffText'] + s:args(s:NONE, s:shitaniro, s:NONE),
\   ['hi', 'FoldColumn'] + s:args(s:kinariiro, s:nurebairo, s:NONE),
\   ['hi', 'SignColumn'] + s:args(s:kinariiro, s:nurebairo, s:NONE),
\   ['hi', 'Pmenu'] + s:args(s:nurebairo, s:kuchinashiiro, s:NONE),
\   ['hi', 'PmenuSel'] + s:args(s:nurebairo, s:higosusutake, s:NONE),
\   ['hi', 'PmenuSbar'] + s:args(s:NONE, s:tonokoiro, s:NONE),
\   ['hi', 'PmenuThumb'] + s:args(s:NONE, s:mokuran, s:NONE),
\   ['hi', 'StatusLine'] + s:args(s:senzaicha, s:urayanagi, s:NONE),
\   ['hi', 'StatusLineNC'] + s:args(s:senzaicha, s:urayanagi, s:NONE),
\   ['hi', 'VertSplit'] + s:args(s:senzaicha, s:urayanagi, s:NONE),
\   ['hi', 'WildMenu'] + s:args(s:kinariiro, s:tetsukon, s:NONE),
\   ['hi', 'TabLine'] + s:args(s:nurebairo, s:kinariiro, s:NONE),
\   ['hi', 'TabLineFill'] + s:args(s:nurebairo, s:kinariiro, s:NONE),
\   ['hi', 'TabLineSel'] + s:args(s:kinariiro, s:tetsukon, s:NONE),
\   ['hi', 'Cursor'] + s:args(s:nurebairo, s:anzuiro, s:NONE),
\   ['hi', 'link', 'CursorIM', 'Cursor'],
\   ['hi', 'CursorLine'] + s:args(s:NONE, s:konnezu, s:NONE[0:0] + s:underline[1:]),
\   ['hi', 'CursorColumn'] + s:args(s:NONE, s:konnezu, s:NONE),
\   ['hi', 'ColorColumn'] + s:args(s:NONE, s:aisumicha, s:NONE),
\   ['hi', 'Visual'] + s:args(s:kinariiro, s:binroujizome, s:NONE),
\   ['hi', 'IncSearch'] + s:args(s:hatobanezumi, s:kurotobi, s:NONE),
\   ['hi', 'Search'] + s:args(s:hatobanezumi, s:kurotobi, s:NONE),
\   ['hi', 'MatchParen'] + s:args(s:NONE, s:dobunezumi, s:NONE),
\   ['hi', 'ModeMsg'] + s:args(s:yamabukicha, s:NONE, s:NONE),
\   ['hi', 'Title'] + s:args(s:kujakuao, s:NONE, s:NONE),
\   ['hi', 'Question'] + s:args(s:rokusho, s:NONE, s:NONE),
\   ['hi', 'MoreMsg'] + s:args(s:yamabukiiro, s:NONE, s:NONE),
\   ['hi', 'ErrorMsg'] + s:args(s:benihi, s:NONE, s:NONE),
\   ['hi', 'WarningMsg'] + s:args(s:sogairo, s:NONE, s:NONE),
\]
" :help group-name
let s:syntaxes = [
\   ['hi', 'Comment'] + s:args(s:fujisusutake, s:NONE, s:NONE),
\   ['hi', 'Conceal'] + s:args(s:kuriiro, s:NONE, s:NONE),
\   ['hi', 'Constant'] + s:args(s:shuiro, s:NONE, s:NONE),
\   ['hi', 'Identifier'] + s:args(s:usugaki, s:NONE, s:NONE),
\   ['hi', 'Statement'] + s:args(s:ouchiiro, s:NONE, s:NONE),
\   ['hi', 'PreProc'] + s:args(s:ayameiro, s:NONE, s:NONE),
\   ['hi', 'Type'] + s:args(s:chigusairo, s:NONE, s:NONE),
\   ['hi', 'Special'] + s:args(s:benimidori, s:NONE, s:NONE),
\   ['hi', 'Underlined'] + s:args(s:misorairo, s:NONE, s:underline),
\   ['hi', 'Ignore'] + s:args(s:tonocha, s:NONE, s:NONE),
\   ['hi', 'Error'] + s:args(s:sumiiro, s:shinshu, s:NONE),
\   ['hi', 'Todo'] + s:args(s:gen, s:nataneaburairo, s:NONE),
\]
for s:highlight in s:highlights + s:syntaxes
    execute join(s:highlight, ' ')
endfor

let &cpo = save_cpo
