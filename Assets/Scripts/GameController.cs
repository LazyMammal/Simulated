using UnityEngine;
using UnityEngine.UI;

public class GameController : MonoBehaviour
{
    public float planetRadius = 22.5f;
    public int propertyID;
    public string propertyName = "_PlanetRadius";
    public float minRadius = 10f;
    public float growFactor = 1.5f;
	public Text radiusText;

    void Awake()
    {
        propertyID = Shader.PropertyToID(propertyName);
	}

    void Start()
    {
        Camera.main.cullingMatrix = new Matrix4x4(Vector4.zero, Vector4.zero,
                                    new Vector4(0.0f, 0.0f, 1.0f, 1.0f), new Vector4(0.0f, 0.0f, -0.6f, 0.0f));
		/*
        Debug.Log("FoV: " + Camera.main.fieldOfView + "\n" +
                "Scale: " + Camera.main.transform.localScale + "\n" +
                Camera.main.cullingMatrix.GetColumn(0) + "\n" +
                Camera.main.cullingMatrix.GetColumn(1) + "\n" +
                Camera.main.cullingMatrix.GetColumn(2) + "\n" +
                Camera.main.cullingMatrix.GetColumn(3));
		 */

		 UpdateRadius(planetRadius);
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Equals) || Input.GetKeyDown(KeyCode.KeypadPlus))
        {
			UpdateRadius(planetRadius * growFactor);
        }
        if (Input.GetKeyDown(KeyCode.Minus) || Input.GetKeyDown(KeyCode.KeypadMinus))
        {
			UpdateRadius(planetRadius / growFactor);
        }
    }

	void UpdateRadius(float newRadius)
	{
		planetRadius = Mathf.Max(minRadius, newRadius);
		radiusText.text = "Radius:  " + Mathf.Round(planetRadius);
		Shader.SetGlobalFloat("gPlanetRadius", planetRadius);
	}
}
