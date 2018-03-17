using System;
using UnityEditor;
using UnityEngine;

[ExecuteInEditMode]
public class RunsInEditor : MonoBehaviour
{
    void Start()
    {
        this.runInEditMode = true;
    }
    public void Update()
    {
        transform.Rotate(.01f, 0, 0);
    }
}

public class RunInEditor : EditorWindow
{
	string playButton = "Stop";
	bool isRunning = true;
    
    [MenuItem("Window/Runs In Editor")]
    static void Initialize()
    {
        Type inspectorType = Type.GetType("UnityEditor.InspectorWindow,UnityEditor.dll");
        EditorWindow window = EditorWindow.GetWindow<RunInEditor>("Runs In Editor", new Type[] { inspectorType });
    }
    void Update()
    {
        if (isRunning && !EditorApplication.isPlaying)
        {
            foreach (GameObject go in GameObject.FindGameObjectsWithTag("EditorOnly"))
            {
                var comp = go.GetComponent<RunsInEditor>();
                if (comp) comp.Update();
            }
        }
    }

	void OnGUI()
	{
		EditorGUILayout.Space();
		if (GUILayout.Button(playButton))
        {
			isRunning = !isRunning;
			playButton = isRunning ? "Stop" : "Play";
		}
	}
}
