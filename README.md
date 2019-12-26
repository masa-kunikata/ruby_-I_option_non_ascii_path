# Windows の日本語を含むパスで require が失敗するケースがある

### 不具合内容

  Windows の日本語を含むパスで ```ruby -I``` オプションでフォルダを指定すると、
  ```$LOAD_PATH``` に、'????'のような文字化けしたパスが追加される様子です。
  
  これによって、 ```require``` が失敗するケースがあると考えています。
  
  日本語を含まない(ascii文字のみ)パスでは、この現象は発生しません。

### 環境

  * Windows 10 Pro
  * ruby 2.6.5p114 (2019-10-01 revision 67812) [x64-mingw32]

### 再現方法

  1. ここのリポジトリをクローンする
  1. コマンドプロンプトを開いて、ここのディレクトリをカレントにする
  1. 下記コマンドを実行する

    > cd あいうえお
    > ruby -Ilib a.rb

  (サンプルフォルダ構造)

      あいうえお
      │  a.rb
      │  
      └─lib
              b.rb


### （参考）詳細情報

<details>
<summary>"あいうえお" フォルダで 'ruby -Ilib a.rb'</summary>
<pre>
C:\ruby_-I_option_non_ascii_path\あいうえお>ruby -Ilib a.rb
Traceback (most recent call last):
        2: from a.rb:17:in `<main>'
        1: from C:/Ruby26-x64/lib/ruby/2.6.0/rubygems/core_ext/kernel_require.rb:54:in `require'
C:/Ruby26-x64/lib/ruby/2.6.0/rubygems/core_ext/kernel_require.rb:54:in `require': cannot load such file -- b (LoadError)

</pre>
</details>

<details>
<summary>"あいうえお" フォルダで 'ruby -Ilib -v a.rb'</summary>
<pre>
C:\ruby_-I_option_non_ascii_path\あいうえお>ruby -Ilib -v a.rb
ruby 2.6.5p114 (2019-10-01 revision 67812) [x64-mingw32]
pp $LOAD_PATH
["C:/ruby_-I_option_non_ascii_path/?????/lib",
 "C:/Ruby26-x64/lib/ruby/gems/2.6.0/gems/did_you_mean-1.3.0/lib",
 "C:/Ruby26-x64/lib/ruby/site_ruby/2.6.0",
 "C:/Ruby26-x64/lib/ruby/site_ruby/2.6.0/x64-msvcrt",
 "C:/Ruby26-x64/lib/ruby/site_ruby",
 "C:/Ruby26-x64/lib/ruby/vendor_ruby/2.6.0",
 "C:/Ruby26-x64/lib/ruby/vendor_ruby/2.6.0/x64-msvcrt",
 "C:/Ruby26-x64/lib/ruby/vendor_ruby",
 "C:/Ruby26-x64/lib/ruby/2.6.0",
 "C:/Ruby26-x64/lib/ruby/2.6.0/x64-mingw32"]
==============================================
  Encoding.default_external: Windows-31J
  Encoding.default_internal:
==============================================
$LOAD_PATH
  0
    path: C:/ruby_-I_option_non_ascii_path/?????/lib
    encoding: Windows-31J
  1
    path: C:/Ruby26-x64/lib/ruby/gems/2.6.0/gems/did_you_mean-1.3.0/lib
    encoding: UTF-8
  2
    path: C:/Ruby26-x64/lib/ruby/site_ruby/2.6.0
    encoding: Windows-31J
  3
    path: C:/Ruby26-x64/lib/ruby/site_ruby/2.6.0/x64-msvcrt
    encoding: Windows-31J
  4
    path: C:/Ruby26-x64/lib/ruby/site_ruby
    encoding: Windows-31J
  5
    path: C:/Ruby26-x64/lib/ruby/vendor_ruby/2.6.0
    encoding: Windows-31J
  6
    path: C:/Ruby26-x64/lib/ruby/vendor_ruby/2.6.0/x64-msvcrt
    encoding: Windows-31J
  7
    path: C:/Ruby26-x64/lib/ruby/vendor_ruby
    encoding: Windows-31J
  8
    path: C:/Ruby26-x64/lib/ruby/2.6.0
    encoding: Windows-31J
  9
    path: C:/Ruby26-x64/lib/ruby/2.6.0/x64-mingw32
    encoding: Windows-31J
==============================================
Traceback (most recent call last):
        2: from a.rb:17:in `<main>'
        1: from C:/Ruby26-x64/lib/ruby/2.6.0/rubygems/core_ext/kernel_require.rb:54:in `require'
C:/Ruby26-x64/lib/ruby/2.6.0/rubygems/core_ext/kernel_require.rb:54:in `require': cannot load such file -- b (LoadError)

</pre>
</details>

<details>
<summary>(OKケース) "abcde" フォルダで 'ruby -Ilib -v a.rb'</summary>
<pre>
C:\ruby_-I_option_non_ascii_path\abcde>ruby -Ilib -v a.rb
ruby 2.6.5p114 (2019-10-01 revision 67812) [x64-mingw32]
pp $LOAD_PATH
["C:/ruby_-I_option_non_ascii_path/abcde/lib",
 "C:/Ruby26-x64/lib/ruby/gems/2.6.0/gems/did_you_mean-1.3.0/lib",
 "C:/Ruby26-x64/lib/ruby/site_ruby/2.6.0",
 "C:/Ruby26-x64/lib/ruby/site_ruby/2.6.0/x64-msvcrt",
 "C:/Ruby26-x64/lib/ruby/site_ruby",
 "C:/Ruby26-x64/lib/ruby/vendor_ruby/2.6.0",
 "C:/Ruby26-x64/lib/ruby/vendor_ruby/2.6.0/x64-msvcrt",
 "C:/Ruby26-x64/lib/ruby/vendor_ruby",
 "C:/Ruby26-x64/lib/ruby/2.6.0",
 "C:/Ruby26-x64/lib/ruby/2.6.0/x64-mingw32"]
==============================================
  Encoding.default_external: Windows-31J
  Encoding.default_internal:
==============================================
$LOAD_PATH
  0
    path: C:/ruby_-I_option_non_ascii_path/abcde/lib
    encoding: Windows-31J
  1
    path: C:/Ruby26-x64/lib/ruby/gems/2.6.0/gems/did_you_mean-1.3.0/lib
    encoding: UTF-8
  2
    path: C:/Ruby26-x64/lib/ruby/site_ruby/2.6.0
    encoding: Windows-31J
  3
    path: C:/Ruby26-x64/lib/ruby/site_ruby/2.6.0/x64-msvcrt
    encoding: Windows-31J
  4
    path: C:/Ruby26-x64/lib/ruby/site_ruby
    encoding: Windows-31J
  5
    path: C:/Ruby26-x64/lib/ruby/vendor_ruby/2.6.0
    encoding: Windows-31J
  6
    path: C:/Ruby26-x64/lib/ruby/vendor_ruby/2.6.0/x64-msvcrt
    encoding: Windows-31J
  7
    path: C:/Ruby26-x64/lib/ruby/vendor_ruby
    encoding: Windows-31J
  8
    path: C:/Ruby26-x64/lib/ruby/2.6.0
    encoding: Windows-31J
  9
    path: C:/Ruby26-x64/lib/ruby/2.6.0/x64-mingw32
    encoding: Windows-31J
==============================================
feature loaded!

</pre>
</details>
