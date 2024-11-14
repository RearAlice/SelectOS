import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    @State private var selectedOS: String? = nil // 選択されたOS
    @State private var showConfirmationDialog = false // 確認ダイアログ表示用
    @State private var isInstalling = false // インストール中かどうか
    @State private var isActivated = false // アクティベート済みかどうか
    @State private var isActivateing = false // アクティベート中かどうか
    @State private var progress: Double = 0.0 // 進捗
    @State private var showCompletionMessage = false // インストール完了メッセージ表示用
    @State private var isHome = false // ホーム画面遷移フラグ
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if isLoading {
                    // ローディングビュー
                    ProgressView("iPhoneのアクティベーションには数分かかることがあります。")
                        .progressViewStyle(CircularProgressViewStyle())
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                } else if isInstalling {
                    ProgressView("インストール中...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                } else if isActivateing {
                    ProgressView("OSをアクティベート中...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                } else if showCompletionMessage {
                    Text("インストールが完了しました！")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding()
                    
                    Button(action: {
                        // ホーム画面に戻る処理
                        isHome = true
                    }) {
                        Text("ホームに戻る")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
                    }
                    .padding()
                    // NavigationLinkを使ってホーム画面に戻る
                    NavigationLink(destination: HomeView(), isActive: $isHome) {
                        EmptyView()
                    }
                } else {
                    // メインコンテンツ
                    VStack(spacing: 20) {
                        VStack(spacing: 10) {
                            Spacer().frame(height: 20)
                            
                            Image(systemName: "gearshape.2")
                                .font(.system(size: 60))
                                .foregroundColor(.blue)
                            
                            Text("システムを選択")
                                .font(.title)
                                .bold()
                            
                            Text("新しいデバイスで使う、オペレーティングシステムを選択します。")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        .padding(.bottom, 30)
                        
                        // システムのリスト
                        List {
                            systemRow(imageName: "iOS", title: "iOS (Apple)", description: "安心のセキュリティと直感的な操作体験。Apple Intelligenceも搭載。")
                            systemRow(imageName: "Android", title: "Android OS (Google)", description: "")
                            systemRow(imageName: "HarmonyOS", title: "HarmonyOS NEXT (Huawei)", description: "")
                            systemRow(imageName: "Ubuntu", title: "Ubuntu Touch (UBports)", description: "")
                            systemRow(imageName: "KaiOS", title: "KaiOS (TCL)", description: "")
                            systemRow(imageName: "Firefox", title: "Firefox OS (Mozilla)", description: "")
                            systemRow(imageName: "Windows_Mobile", title: "Windows Mobile (Microsoft)", description: "")
                            systemRow(imageName: "iTunes", title: "iTunesに接続", description: "")
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: resetSelection) {
                                Text("リセット")
                            }
                        }
                    }
                    .alert(isPresented: $showConfirmationDialog) {
                        Alert(
                            title: Text("インストール確認"),
                            message: Text("\(selectedOS ?? "") をインストールしますか？"),
                            primaryButton: .destructive(Text("インストール")) {
                                installOS()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .onAppear {
                // 5秒後にローディングを終了
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        }
    }

    // システムの行を生成するヘルパーメソッド
    func systemRow(imageName: String, title: String, description: String) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                if !description.isEmpty {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
        .onTapGesture {
            selectedOS = title // OSを選択
            showConfirmationDialog = true // 確認ダイアログを表示
        }
    }

    // リセットボタンのアクション
    func resetSelection() {
        selectedOS = nil
    }

    // OSのインストール処理
    func installOS() {
        // インストールを開始
        isInstalling = true
        progress = 0.0
        
        // 5秒後にインストール完了
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            stopInstallation()
        }
    }
    
    // インストール完了後の処理
    func stopInstallation() {
        isInstalling = false
        isActivateing = true
        
        // 5秒後にアクティベーション完了
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completeActivation()
        }
    }
    
    // アクティベーション完了後の処理
    func completeActivation() {
        isActivateing = false
        showCompletionMessage = true
    }
}

// ホーム画面の仮ビュー
struct HomeView: View {
    var body: some View {
        VStack {
            Text("ホーム画面")
                .font(.largeTitle)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
