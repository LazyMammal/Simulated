using UnityEngine;

//[ExecuteInEditMode]
public class SpawnCubes : MonoBehaviour
{
	public Vector3Int size = new Vector3Int(16, 4, 16);
	public Vector3 origin = Vector3.zero, spacing = Vector3.one * 2f;
	public GameObject cube;
    void Start()
    {
		Transform[] allChildren = GetComponentsInChildren<Transform>();
		foreach(Transform child in allChildren) {
			if( child && child != transform)
			{
				DestroyImmediate(child.gameObject);
			}
		}

		for(int x = 0; x < size.x; x++)
			for(int y = 0; y < size.y; y++)
				for(int z = 0; z < size.z; z++)
					SpawnCube(x, y, z);
    }

	public void SpawnCube(float x, float y, float z)
	{
		Vector3 pos = origin + new Vector3(x * spacing.x, -y * spacing.y, z * spacing.z);
		var go = Instantiate(cube, pos, Quaternion.identity);
		go.transform.parent = transform;
	}
}
