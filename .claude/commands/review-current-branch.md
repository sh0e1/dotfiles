---
description: Review current branch changes compared to base branch
argument-hint: [base-branch]
allowed-tools: Bash(git branch:*), Bash(git status:*), Bash(git symbolic-ref:*), Bash(git merge-base:*), Bash(git diff:*), Bash(git log:*)
---

現在のブランチの変更内容をbaseブランチ（$ARGUMENTSで指定、デフォルト: 動的に検出されたbaseブランチ）と比較してレビューしてください。

まず以下のコマンドを実行して現在の状態を確認してください：
!git branch --show-current
!git status --short

デフォルトブランチを取得：
!git symbolic-ref --short refs/remotes/origin/HEAD

現在のブランチのbaseブランチを動的に検出：
!git merge-base HEAD origin/main

次に、baseブランチからのcommit済み変更のみを確認してください（未commit変更は除外）：
$ARGUMENTSが指定されている場合はそのブランチを、指定されていない場合は上記で検出したbaseブランチを使用してください。
!git diff origin/main..HEAD --stat
!git log --oneline origin/main..HEAD

その後、commit済み変更の詳細な差分を確認してください：
!git diff origin/main..HEAD

レビューは以下の観点で行ってください：

## コードレビューチェックリスト

### 1. コード品質

- [ ] コーディング規約に準拠しているか
- [ ] 不要なコメントアウトやデバッグコードが残っていないか
- [ ] 適切な変数名・関数名が使用されているか

### 2. ロジックと実装

- [ ] ビジネスロジックが正しく実装されているか
- [ ] エッジケースが考慮されているか
- [ ] 重複したコードがないか

### 3. エラーハンドリング

- [ ] 適切なエラーハンドリングが実装されているか
- [ ] エラーメッセージが分かりやすいか

### 4. セキュリティ

- [ ] SQLインジェクションなどの脆弱性がないか
- [ ] 機密情報がハードコードされていないか
- [ ] 適切な認証・認可が実装されているか

### 5. パフォーマンス

- [ ] 不要なループや処理がないか
- [ ] 適切なインデックスが使用されているか
- [ ] N+1問題などがないか

### 6. テスト

- [ ] 新しい機能に対するテストが追加されているか
- [ ] 既存のテストが壊れていないか

レビュー結果を日本語でまとめ、改善点があれば具体的な提案を含めてください。
