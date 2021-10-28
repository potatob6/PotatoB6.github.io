public class Roller{
    static float timer = .0f;
    public static void main(String[] args) {
        //选项解析
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
                        System.out.println("使用指南:\n\t-A <num>\t;振幅\n\t-b <num> "+
                        "\t;偏置\n\t-w <num>\t;1/频率");
                        System.exit(0);
                    default:
                        System.out.printf("未知参数:%s",args[pointer]);
                        System.out.println("使用指南:\n\t-A <num>\t;振幅\n\t-b <num> "+
                        "\t;偏置\n\t-w <num>\t;1/频率");
                        System.exit(1);
                }
            }catch(NumberFormatException e){
                System.out.println(args[pointer]+"使用了非数字类型");
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
        System.out.println("程序异常退出");
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