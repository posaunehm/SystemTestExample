*** Settings ***

Library  Selenium2Library


*** Keywords ***
GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
    create webdriver  Chrome

    # Googleのトップ画面を開く
    go to  https://www.google.co.jp/

    # タイトルにGoogleが含まれていることを確認する
    ${page_title} =  get title
    should contain  ${page_title}  Google

    # 検索後を入力して送信する
    input text  name=q  Python
    # Robot FrameworkではEnterキーは\\13になる
    # https://github.com/robotframework/Selenium2Library/issues/4
    press key  name=q  \\13

    # Ajax遷移のため、2秒待つ
    # FixMe: 本当は `Wait Until Element Is Visible` を使うべき
    sleep  2sec

    # タイトルにPythonが含まれていることを確認する
    ${result_title} =  get title
    should contain  ${result_title}  Python

    # スクリーンショットを撮る
    capture page screenshot  filename=result_google_python.png

    # ログを見やすくするために改行を入れる
    log to console  ${SPACE}

    # 検索結果を表示する
    # ForでElementを回したかったことから、WebElementを取得し、そのAPIを利用する
    @{web_elements} =  get webelements  css=h3 > a
    :for  ${web_element}  in  @{web_elements}
    \  ${text} =  get text  ${web_element}
    \  log to console  ${text}
    \  ${href} =  call method  ${web_element}  get_attribute  href
    \  log to console  ${href}

    # ブラウザを終了する
    close browser


*** TestCases ***

GoogleでPythonを検索するテスト
    GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する







