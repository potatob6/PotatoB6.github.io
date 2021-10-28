public class Roller{
    static float timer = .0f;
    public static void main(String[] args) {
        //ѡ�����
        int A = 20;
        int b = 20;
        float w = 1;
        int pointer = 0;
        while(pointer<args.length){
            try{
                switch(args[pointer]){
                    case "-A":
                        pointer++;
                        A =Integer.parseInt(args[pointer]);
                        pointer++;
                        continue;
                    case "-b":
                        pointer++;
                        b = Integer.parseInt(args[pointer]);
                        pointer++;
                        continue;
                    
                    case "-w":
                        pointer++;
                        w = Integer.parseInt(args[pointer]);
                        pointer++;
                        continue;
                    case "--help":
                        System.out.println("ʹ��ָ��:\n\t-A <num>\t;���\n\t-b <num> "+
                        "\t;ƫ��\n\t-w <num>\t;1/Ƶ��");
                        System.exit(0);
                    default:
                        System.out.printf("δ֪����:%s",args[pointer]);
                        System.out.println("ʹ��ָ��:\n\t-A <num>\t;���\n\t-b <num> "+
                        "\t;ƫ��\n\t-w <num>\t;1/Ƶ��");
                        System.exit(1);
                }
            }catch(NumberFormatException e){
                System.out.println(args[pointer]+"ʹ���˷���������");
                System.exit(3);
            }
        }
        while(true){
            int l =(int)(Math.sin(timer*w) * A + b);
            System.out.println(Roller.getLengthString(l));
            timer += .06f;
            try {
                Thread.sleep(16);
            } catch (Exception e) {
                e.printStackTrace();
                break;
            }
        }
        System.out.println("�����쳣�˳�");
        System.exit(2);
    }

    static String getLengthString(int n){
        StringBuilder sBuilder = new StringBuilder();
        for(int i = 0;i<n;i++){
            sBuilder.append('*');
        }
        return sBuilder.toString();
    }
}