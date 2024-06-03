@isTest
public class LeadConvertTest {
	@isTest
    static void LeadConvertSuccess(){
        Date today = date.today();
        String con =  'テスト' + String.valueOf(today);
        // 事前データチェック
        List<Account> a = [SELECT Id, Name FROM Account WHERE Name =:con];
        System.AssertEquals(a.Size(), 0);
		// 変換開始
        List<Lead> leads= [SELECT Id , Name FROM Lead WHERE LastName = :con];
        List<String> results = LeadConvert.Convert(leads);
        
        // 結果チェック
        // リード
        
        for (String r : results){
            System.AssertEquals(r, 'Success');
        }
        // 取引先
        List<Account> aRes = [SELECT Id, Name FROM Account WHERE Name =:con];
        System.AssertEquals(aRes.Size(), 1); 
    } 
    
    @isTest
    static void LeadConvertError(){
        Date today = date.today();
        String con =  'テスト' + String.valueOf(today);
        // 変換開始
        List<Lead> leads= [SELECT Id , Name FROM Lead WHERE LastName = :con];
        List<String> preResults = LeadConvert.Convert(leads);
        for (String r : preResults){
            System.AssertEquals(r, 'Success');
        }
        
        // 再度実施
        List<String> results = LeadConvert.Convert(leads);
        // 結果チェック
        for (String r : results){
            System.AssertEquals(r, 'Failer');
        }
    }
 	
    @TestSetup
    static void createData(){
  		 // リード作成
  		 Date today = date.today();
  		 insert new Lead(LastName = 'テスト' + String.valueOf(today));
    }
    
}