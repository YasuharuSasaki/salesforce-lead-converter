public class LeadConvert {
//Convertメソッドの引数にフローからリードを渡す
    @InvocableMethod(label='LeadConvert')
    public static List<String> Convert(List<Lead> inputs){
        
        // フローに返す文字列型の配列を生成
        List<String> resultLeadConvertList = new List<String>();

        //フローから渡されたリード件数分ループ
        for(Lead lead : inputs){
            
            // リードをコンバートする
            // LeadConvertクラスのインスタンス化
            Database.LeadConvert lc = new Database.LeadConvert();
            
            lc.setLeadId(lead.Id); //変換するリードIDを設定
            
            //取引開始済みに設定されているリード状況取得
            LeadStatus[] convertStatus = [SELECT Id,ApiName FROM LeadStatus WHERE IsConverted = true LIMIT 1];

            lc.setConvertedStatus(convertStatus[0].ApiName); //処理後のリード状況に取引開始済みの値を設定
            lc.setDoNotCreateOpportunity(true); //商談の作成不可
            
            try{
                Database.LeadConvertResult lcr = Database.convertLead(lc); // 取引の開始
                resultLeadConvertList.add('Success');//取引の開始成功
                    
            }catch(Exception e){
                resultLeadConvertList.add('Failer');//取引の開始失敗
            }

        }
        return resultLeadConvertList;
    }
}