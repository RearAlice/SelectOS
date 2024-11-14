import SwiftUI

struct ContentView: View {
    @State private var isLoading = true // ローディング状態の管理

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if isLoading {
                    // ローディングビュー
                    ProgressView("Loading...") // ローディング表示
                        .progressViewStyle(CircularProgressViewStyle())
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // メインコンテンツ
                    VStack(spacing: 20) {
                        // ヘッダーアイコンとタイトル
                        VStack(spacing: 10) {
                            Spacer() // 追加して位置調整
                                .frame(height: 20)
                            
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
            Image(imageName) // カスタム画像セットを使用
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
    }

    // リセットボタンのアクション
    func resetSelection() {
        // ここにリセット動作を実装
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
