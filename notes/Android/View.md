# View

## 构造函数

```java
public class MainBottomTabGroupView extends TabGroupView {
    /**
     * 在Java代码中直接new一个MainBottomTabGroupView的实例, 会调用一个参数的构造函数
     */
    public MainBottomTabGroupView(Context context) {
        super(context);
    }

    /**
     * 在xml中引用MainBottomTabGroupView标签时, 会调用两个参数的构造函数
     */
    public MainBottomTabGroupView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    /**
     * 3个参数的构造函数一般由我们主动调用
     */
    public MainBottomTabGroupView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    @Override
    protected View createView(TabItem item) {
        MainBottomTabItem mainBottomTabItem = new MainBottomTabItem(getContext());
        if (item.animationDrawableBean != null) {
            mainBottomTabItem.setAnimationDrawable(item.animationDrawableBean);
        } else {
            mainBottomTabItem.setDrawable(item.drawable);
        }
        mainBottomTabItem.setName(item.text);
        return mainBottomTabItem;
    }
}
```

