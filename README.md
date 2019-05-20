#Code Explanation of soble_op():

##Section1. 
讀取input圖檔的行列數、pixel數，並將圖檔轉成灰階以供後續使用。

##Section2. 
使用Median Filter對灰階圖進行去雜訊處理，首先將圖片切割成3x3的block，
接著找出該block的中位數，並將每個pixel的值替換成其對應block的中位數。

##Section3.
對去雜訊過後的圖像進行histogram equalization，首先計算每個pixel值出現的次數，再計算從0~255 pixel值的cumulative probability，最後將每個pixel替換為其pixel值對應之cumulative probability乘上255後的取整值。

##Section4.
將經過histogram equalization的圖像分成3x3的block，並把每個block分別乘上x方向與y方向的高斯矩陣，接著計算乘完後的矩陣總和，並將x方向與y方向之總和分別平方後相加取平方根，結果即為對應pixel經過sobel operator後的值。

##Section5.
使用Median Filter對經過sobel operator後的圖像再次進行去雜訊處理。
