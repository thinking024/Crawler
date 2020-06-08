package util;

import sun.awt.windows.ThemeReader;

import java.util.concurrent.Callable;
import java.util.concurrent.FutureTask;

public class MutipleThread implements Runnable {
    @Override
    public void run() {
        fun();
    }

    public void fun() {
        for (int i=1;i < 100;i++) {
            System.out.println(Thread.currentThread().getName());
            System.out.println(i);
        }
    }

    public static void main(String[] args) {
        /*Thread thread1 = new Thread(new MutipleThread());
        Thread thread2 = new Thread(new MutipleThread());
        Thread thread3 = new Thread(new MutipleThread());
        thread1.start();
        thread2.start();
        thread3.start();*/

        B b =new B();

        //1.执行 Callable 方式，需要 FutureTask 实现类的支持，用于接收运算结果。
        FutureTask result1 =new FutureTask<>(b);
        FutureTask result2 =new FutureTask<>(b);
        FutureTask result3 =new FutureTask<>(b);
        Thread thread1 = new Thread(result1, "a");
        Thread thread2 = new Thread(result1,"b");
        Thread thread3 = new Thread(result1,"c");
        thread1.start();
        thread2.start();
        thread3.start();
    }
}

class B implements Callable {

    @Override
    public Object call() throws Exception {
        MutipleThread mutipleThread = new MutipleThread();
        mutipleThread.fun();
        return null;
    }
}
